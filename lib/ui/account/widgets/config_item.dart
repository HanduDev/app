import 'package:app/ui/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

class ConfigItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const ConfigItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.black, size: 24),
      title: Text(title, style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: AppColors.black,
      )),
      onTap: onTap,
    );
  }
}
