import 'package:app/helpers/errors.dart';
import 'package:app/helpers/toast.dart';
import 'package:app/models/lesson/lesson.dart';
import 'package:app/models/lesson/lesson_info.dart';
import 'package:app/ui/lesson/view_model/lesson_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';

class LessonBody extends StatelessWidget {
  final Lesson lesson;

  const LessonBody({super.key, required this.lesson});

  @override
  Widget build(BuildContext context) {
    Future<LessonInfo?> fetchData() async {
      try {
        return await context.read<LessonViewModel>().initialize(lesson.id);
      } catch (e) {
        if (context.mounted) {
          Toast.error(context, getErrorMessage(e));
        }

        return null;
      }
    }

    return FutureBuilder(
      future: fetchData(),
      initialData: null,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 16, 12, 16),
                child: MarkdownBody(data: snapshot.data?.content ?? ""),
              ),
            ),
          );
        }
      },
    );
  }
}
