import 'package:app/models/trail/trail.dart';
import 'package:app/ui/core/shared/progress_bar.dart';
import 'package:app/ui/core/shared/shared_header.dart';
import 'package:app/ui/core/themes/app_colors.dart';
import 'package:app/ui/core/themes/font.dart';
import 'package:app/ui/trail/widgets/trail_body.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TrailPage extends StatelessWidget {
  final Trail trail;

  const TrailPage({super.key, required this.trail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SharedHeader(
              title: Text(
                trail.name,
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
                    trail.language.code,
                    shape: const RoundedRectangle(8),
                    width: 40,
                    height: 27,
                  ),
                  const SizedBox(width: 8),
                  Material(
                    type: MaterialType.transparency,
                    child: Text(
                      trail.language.name,
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
                        tag: '${trail.id}-progress',
                        child: ProgressBar(value: trail.progress),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Hero(
                      tag: '${trail.id}-progress-text',
                      child: Text(
                        '${trail.progress * 100} %',
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
            TrailBody(trail: trail),
          ],
        ),
      ),
    );
  }
}
