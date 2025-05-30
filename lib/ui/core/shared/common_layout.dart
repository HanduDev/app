import 'package:app/providers/languages_provider.dart';
import 'package:app/routes/destination.dart';
import 'package:app/ui/core/themes/app_colors.dart';
import 'package:app/ui/core/themes/font.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';

class CommonLayout extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const CommonLayout({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    const destinations = [
      Destination(label: 'bottom_navigation.translate', icon: Icons.translate),
      Destination(
        label: 'bottom_navigation.libras',
        icon: Icons.sign_language_outlined,
      ),
      Destination(label: 'bottom_navigation.education', icon: Icons.school),
      Destination(
        label: 'bottom_navigation.account',
        icon: Icons.person_outline,
      ),
    ];

    return Scaffold(
      body: SafeArea(child: navigationShell),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          labelTextStyle: WidgetStateTextStyle.resolveWith((
            Set<WidgetState> states,
          ) {
            final bool isSelected = states.contains(WidgetState.selected);

            final Color color =
                isSelected ? AppColors.white : AppColors.disabledIcon;

            final FontWeight fontWeight =
                isSelected ? FontWeight.w700 : FontWeight.w400;

            return Font.primary(
              color: color,
              fontWeight: fontWeight,
              fontSize: 12,
            );
          }),
        ),
        child: FutureBuilder(
          future: context.read<LanguagesProvider>().getAllLanguages(),
          builder: (context, _) {
            return NavigationBar(
              selectedIndex: navigationShell.currentIndex,
              onDestinationSelected: navigationShell.goBranch,
              backgroundColor: AppColors.primary400,
              indicatorColor: AppColors.primary400,
              destinations:
                  destinations
                      .map(
                        (destination) => NavigationDestination(
                          icon: Icon(
                            destination.icon,
                            color: AppColors.disabledIcon,
                            size: 30,
                          ),
                          label: destination.label.i18n(),
                          selectedIcon: Icon(
                            destination.icon,
                            color: AppColors.white,
                            size: 30,
                          ),
                        ),
                      )
                      .toList(),
            );
          },
        ),
      ),
    );
  }
}
