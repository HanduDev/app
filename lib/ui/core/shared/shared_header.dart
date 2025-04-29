import 'package:app/ui/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

class SharedHeader extends StatelessWidget {
  final Widget title;
  final Widget? subtitle;
  final VoidCallback? onBackPressed;

  const SharedHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 12, right: 12, top: 20, bottom: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.primary400, AppColors.primary200],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (onBackPressed != null)
                IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    size: 24,
                    color: AppColors.white,
                  ),
                  onPressed: onBackPressed,
                ),

              Flexible(
                child: Column(
                  children: [
                    title,
                    if (subtitle != null) const SizedBox(height: 8),
                    if (subtitle != null) subtitle!,
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
