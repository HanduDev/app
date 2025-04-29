import 'package:app/helpers/errors.dart';
import 'package:app/helpers/toast.dart';
import 'package:app/models/trail/trail.dart';
import 'package:app/models/trail/trail_info.dart';
import 'package:app/routes/routes.dart';
import 'package:app/ui/core/shared/progress_bar.dart';
import 'package:app/ui/core/shared/shared_header.dart';
import 'package:app/ui/core/themes/app_colors.dart';
import 'package:app/ui/core/themes/font.dart';
import 'package:app/ui/trail/view_model/trail_view_model.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class TrailPage extends StatefulWidget {
  final Trail trail;

  const TrailPage({super.key, required this.trail});

  @override
  State<TrailPage> createState() => _TrailPageState();
}

class _TrailPageState extends State<TrailPage> {
  void fetchData() async {
    try {
      await context.read<TrailViewModel>().initialize(widget.trail.id);
    } catch (e) {
      if (mounted) {
        Toast.error(context, getErrorMessage(e));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchData();
    });
  }

  Widget body(TrailInfo? trail, bool isLoading) {
    if (trail == null || isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (trail.lessons.isEmpty) {
      return Center(child: Text('No lessons available'));
    }

    return Expanded(
      child: ListView.builder(
        itemCount: trail.lessons.length,
        itemBuilder: (context, index) {
          final lesson = trail.lessons[index];

          return ListTile(
            onTap: () {
              context.push(Routes.aula, extra: {"lesson": lesson});
            },
            title: Hero(tag: "${lesson.id}-title", child: Text(lesson.name)),
            subtitle: Text(lesson.hasFinished ? 'Finished' : 'Not finished'),
            trailing: Icon(
              lesson.hasFinished ? Icons.check_circle : Icons.circle,
              color: lesson.hasFinished ? Colors.green : Colors.grey,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final trail = context.select<TrailViewModel, TrailInfo?>(
      (value) => value.trail,
    );

    final isLoading = context.select<TrailViewModel, bool>(
      (value) => value.isLoading,
    );

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SharedHeader(
              title: Text(
                trail?.name ?? widget.trail.name,
                style: Font.primary(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: AppColors.white,
                ),
              ),
              onBackPressed: () {
                context.pop();
              },
              subtitle: Row(
                children: [
                  CountryFlag.fromLanguageCode(
                    widget.trail.language.code,
                    shape: const RoundedRectangle(8),
                    width: 40,
                    height: 27,
                  ),
                  const SizedBox(width: 8),
                  Material(
                    type: MaterialType.transparency,
                    child: Text(
                      widget.trail.language.name,
                      style: Font.primary(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.white,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Flexible(
                      child: Hero(
                        tag: '${widget.trail.id}-progress',
                        child: ProgressBar(value: widget.trail.progress),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Hero(
                      tag: '${widget.trail.id}-progress-text',
                      child: Text(
                        '${widget.trail.progress} %',
                        style: Font.primary(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            body(trail, isLoading),
          ],
        ),
      ),
    );
  }
}
