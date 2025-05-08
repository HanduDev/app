import 'dart:convert';
import 'package:app/data/services/web_socket.dart';
import 'package:app/models/trail/trail.dart';
import 'package:app/models/user.dart';
import 'package:app/providers/auth_provider.dart';
import 'package:app/routes/routes.dart';
import 'package:app/ui/core/themes/app_colors.dart';
import 'package:app/ui/plano_de_estudos/widgets/create_step_animations/loading.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
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

  WebSocketChannel _setupWebSocket() {
    final channel = WebSocketChannel.connect(Uri.parse('$url/cable'));

    final user = Provider.of<AuthProvider>(context, listen: false).user;

    if (user == null) {
      return channel;
    }

    final data = {
      'command': 'subscribe',
      'identifier': jsonEncode({'channel': 'TrailChannel', 'user_id': user.id}),
    };

    channel.sink.add(jsonEncode(data));

    return channel;
  }

  Map<String, dynamic>? _checkSuccess(dynamic data) {
    try {
      final decoded = jsonDecode(data);

      if (decoded['message'] is! Map<String, dynamic>) {
        return null;
      }

      return decoded['message'];
    } catch (e) {
      return {'error': 'Erro ao criar o plano de estudos'};
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = context.select<AuthProvider, User?>((value) => value.user);

    if (user == null) {
      return const Center(child: Text('Nenhum usuário encontrado'));
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
                        return Center(child: Text('Conectando ao servidor...'));
                      }

                      if (snapshot.hasError) {
                        return Center(
                          child: Text('Erro de conexão: ${snapshot.error}'),
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
