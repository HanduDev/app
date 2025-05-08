import 'package:app/models/trail/trail.dart';
import 'package:app/routes/routes.dart';
import 'package:app/ui/trail/view_model/trail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
          child: ListView.builder(
            itemCount: trailInfo.lessons.length,
            itemBuilder: (context, index) {
              final lesson = trailInfo.lessons[index];

              return ListTile(
                onTap: () {
                  context.push(Routes.aula, extra: {"lesson": lesson});
                },
                title: Hero(
                  tag: "${lesson.id}-title",
                  child: Text(lesson.name),
                ),
                trailing: Icon(
                  lesson.hasFinished ? Icons.check_circle : Icons.circle,
                  color: lesson.hasFinished ? Colors.green : Colors.grey,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
