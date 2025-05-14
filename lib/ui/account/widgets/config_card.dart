import 'package:app/ui/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

class ConfigCard extends StatelessWidget {
  final List<Widget> widgets;
 
  const ConfigCard({
    super.key,
    required this.widgets,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40,),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 20,
            ),
          ],),  
          child: Column(
            children: widgets,
          ),
      ),
    );  
  }
}
