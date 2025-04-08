import 'package:app/providers/auth_provider.dart';
import 'package:app/ui/core/shared/dropdown_button.dart';
import 'package:app/ui/core/shared/gradient_background.dart';
import 'package:app/ui/core/shared/segmented_control/segmented_control.dart';
import 'package:app/ui/core/shared/segmented_control/segmented_control_item.dart';
import 'package:app/ui/core/themes/app_colors.dart';
import 'package:app/ui/core/themes/font.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TranslateTextPage extends StatelessWidget {
  const TranslateTextPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        return GradientBackground(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                SizedBox(height: 80),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Boas vindas ao Handu,',
                            style: Font.primary(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              color: AppColors.yellow,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            authProvider.user?.fullName ?? '',
                            style: Font.primary(
                              fontSize: 25,
                              fontWeight: FontWeight.w800,
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 30),
                    GestureDetector(
                      onTap: () {},
                      child: CircleAvatar(
                        radius: 25,
                        backgroundImage:
                            authProvider.user?.photoURL != null
                                ? NetworkImage(authProvider.user!.photoURL!)
                                : null,
                        backgroundColor: AppColors.primary100,
                        child:
                            authProvider.user?.photoURL == null
                                ? Icon(
                                  Icons.person, // Ícone padrão
                                  size: 30,
                                  color: AppColors.white,
                                )
                                : null,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 64),
                SegmentedControl(
                  initialIndex: 1,
                  onChange: (value) {},
                  items: [
                    SegmentedControlItem(
                      key: '/intro',
                      text: "Texto",
                      icon: Icons.text_snippet_outlined,
                    ),
                    SegmentedControlItem(
                      key: '/intro',
                      text: "Audio",
                      icon: Icons.mic_none_outlined,
                    ),
                    SegmentedControlItem(
                      key: '/intro',
                      text: "Imagem",
                      icon: Icons.image_outlined,
                    ),
                  ],
                ),
                LanguageSelector(),
              ],
            ),
          ),
        );
      },
    );
  }
}
