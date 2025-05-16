import 'package:app/models/trail/trail.dart';
import 'package:app/ui/trail/view_model/trail_view_model.dart';
import 'package:app/ui/trail/widgets/lesson_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TrailBody extends StatelessWidget {
  final Trail trail;

  const TrailBody({super.key, required this.trail});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.read<TrailViewModel>().initialize(trail.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('${snapshot.error}'));
        }

        final trailInfo = snapshot.data;

        if (trailInfo == null) {
          return const Center(child: Text('Nenhum dado encontrado'));
        }

        return Expanded(
          child: ListView.separated(
            itemCount: trailInfo.lessons.length,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            shrinkWrap: true,
            separatorBuilder: (context, index) {
              return const SizedBox(height: 16);
            },
            itemBuilder: (context, index) {
              final lesson = trailInfo.lessons[index];
              bool isPreviousFinished =
                  index > 0 && trailInfo.lessons[index - 1].hasFinished;
              bool isNextFinished =
                  index < trailInfo.lessons.length - 1 &&
                  trailInfo.lessons[index + 1].hasFinished;
              bool isCurrentLesson = isPreviousFinished && !isNextFinished;
              return LessonCard(
                lesson: lesson,
                isCurrentLesson: isCurrentLesson,
              );
            },
          ),
        );
      },
    );
  }
}
