import 'package:app/models/language.dart';
import 'package:app/ui/core/themes/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardRecommendation extends StatelessWidget {
  final Map<String, dynamic> language;
  final String level;
  final int persons;

  const CardRecommendation({
    super.key,
    required this.language,
    required this.level,
    required this.persons,
  });

  @override
  Widget build(BuildContext){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            width: 160,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: AppColors.primary500,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 6),
                Text(
                  language['countryCode'],
                ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    '$level em ${language['name']}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                    maxLines: 1,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '$persons pessoas',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.lightGrey,
                  ),
                ),
                ],
              ),
            ),
          )
      ],
    );
  }
  
}