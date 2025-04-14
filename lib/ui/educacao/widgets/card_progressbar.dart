import 'package:app/ui/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

class CardProgressBar extends StatelessWidget {
  final String title;
  final double progress;
  final String progressText;

  const CardProgressBar({
    super.key,
    required this.title,
    required this.progress,
    required this.progressText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Container(
            width: 160,
            height: 100,
            color: AppColors.primary500,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 6),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(height: 10),

                 SizedBox(
                    height: 8,
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Container(
                            width: double.infinity,
                            color: AppColors.primary400,
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Container(
                            width: MediaQuery.of(context).size.width * progress * 0.35,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  AppColors.progressGradient[0],
                                  AppColors.progressGradient[1],
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                const SizedBox(height: 10),
                Row(
                  children: [
                    Text('Progresso', style: 
                    TextStyle(
                      fontSize: 12,
                      color: AppColors.lightGrey,
                    ),),
                    const SizedBox(width: 20),
                    Text(
                      progressText,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.lightGrey,
                      ),
                    ),
                  ],
                )
              ],
              ),
            ),
          ),
        )
      ],
    );
  }
}