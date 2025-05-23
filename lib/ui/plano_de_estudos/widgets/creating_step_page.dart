import 'dart:convert';
import 'package:app/config/environment.dart';
import 'package:app/models/trail/trail.dart';
import 'package:app/models/user.dart';
import 'package:app/providers/auth_provider.dart';
import 'package:app/routes/routes.dart';
import 'package:app/ui/core/themes/app_colors.dart';
import 'package:app/ui/plano_de_estudos/widgets/create_step_animations/loading.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class CreatingStepPage extends StatefulWidget {
  const CreatingStepPage({super.key});

  @override
  State<CreatingStepPage> createState() => _CreatingStepPageState();
}

class _CreatingStepPageState extends State<CreatingStepPage>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late WebSocketChannel _channel;
  Trail? _trail;

  String getWebSocketUrl() {
    final uri = Uri.parse(Environment.baseUrl);
    final wsScheme = uri.scheme == 'https' ? 'wss' : 'ws';

    final port =
        (uri.scheme == 'https' && uri.port == 443) ||
                (uri.scheme == 'http' && uri.port == 80)
            ? ''
            : ':${uri.port}';

    return '$wsScheme://${uri.host}$port/cable';
  }

  WebSocketChannel _setupWebSocket() {
    try {
      final uri = Uri.parse(getWebSocketUrl());

      final channel =
          kIsWeb
              ? WebSocketChannel.connect(uri)
              : IOWebSocketChannel.connect(uri);

      final user = Provider.of<AuthProvider>(context, listen: false).user;

      if (user == null) {
        return channel;
      }

      final data = {
        'command': 'subscribe',
        'identifier': jsonEncode({
          'channel': 'TrailChannel',
          'user_id': user.id,
        }),
      };

      channel.sink.add(jsonEncode(data));

      return channel;
    } catch (e) {
      rethrow;
    }
  }

  Map<String, dynamic>? _checkSuccess(dynamic data) {
    try {
      final decoded = jsonDecode(data);

      if (decoded['message'] is! Map<String, dynamic>) {
        return null;
      }

      return decoded['message'];
    } catch (e) {
      return {'error': 'plano_de_estudos.error_creating_study_plan'.i18n()};
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = context.select<AuthProvider, User?>((value) => value.user);

    if (user == null) {
      return Center(child: Text('plano_de_estudos.no_user_found'.i18n()));
    }

    return Scaffold(
      backgroundColor: AppColors.primary300,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: StreamBuilder(
                    stream: _channel.stream,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            'plano_de_estudos.connecting_to_server'.i18n(),
                          ),
                        );
                      }

                      if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            'plano_de_estudos.connection_error'
                                .i18n()
                                .replaceAll(
                                  "{{error}}",
                                  snapshot.error.toString(),
                                ),
                          ),
                        );
                      }

                      if (snapshot.hasData) {
                        final data = _checkSuccess(snapshot.data);

                        if (data != null) {
                          Future.microtask(() {
                            if (!context.mounted) {
                              return;
                            }

                            if (data['error'] != null) {
                              context.pushReplacement(
                                Routes.finalizarPlanoDeEstudos,
                                extra: {
                                  'errorMessage': data['error'],
                                  'trail': _trail,
                                },
                              );
                              return;
                            }

                            if (data['trail'] != null) {
                              context.pushReplacement(
                                Routes.finalizarPlanoDeEstudos,
                                extra: {'trail': Trail.fromJson(data['trail'])},
                              );
                            }
                          });
                        }
                      }

                      return Loading();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _channel = _setupWebSocket();
  }

  @override
  void dispose() {
    _controller.dispose();
    _channel.sink.close();
    super.dispose();
  }
}
