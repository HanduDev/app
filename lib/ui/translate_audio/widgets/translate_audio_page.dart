import 'package:app/providers/auth_provider.dart';
import 'package:app/ui/core/shared/dropdown_button.dart';
import 'package:app/ui/core/shared/gradient_background.dart';
import 'package:app/ui/core/shared/segmented_control/segmented_control.dart';
import 'package:app/ui/core/shared/segmented_control/segmented_control_item.dart';
import 'package:app/ui/core/themes/app_colors.dart';
import 'package:app/ui/core/themes/font.dart';
import 'package:app/ui/traducao_texto/view_model/translate_text_view_model.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class TranslateAudioPage extends StatelessWidget {
  const TranslateAudioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        return Consumer<TranslateTextViewModel>(
          builder: (context, viewModel, child) {
            return GradientBackground(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    SizedBox(height: 64),
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
                                authProvider.user?.fullName.split(' ').first ??
                                    '',
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
                    Hero(
                      tag: 'segmented',
                      child: SegmentedControl(
                        initialIndex: 1,
                        onChange: (value) {
                          context.go(value);
                        },
                        items: [
                          SegmentedControlItem(
                            key: '/home',
                            text: "Texto",
                            icon: Icons.text_snippet_outlined,
                          ),
                          SegmentedControlItem(
                            key: '/audio',
                            text: "Audio",
                            icon: Icons.mic_none_outlined,
                          ),
                          SegmentedControlItem(
                            key: '/home',
                            text: "Imagem",
                            icon: Icons.image_outlined,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40),
                    Hero(
                      tag: "dropdown-languages",
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Dropdown(
                              data: viewModel.languages,
                              leading:
                                  (value) => CountryFlag.fromLanguageCode(
                                    value['countryCode']!,
                                    height: 20,
                                    width: 30,
                                  ),
                              render: (value) {
                                return Text(value['name']!);
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                // Lógica para trocar as linguagens
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 4,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.swap_horiz, // Ícone de troca
                                  color: AppColors.primary400,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Dropdown(
                              data: viewModel.languages,
                              leading:
                                  (value) => CountryFlag.fromLanguageCode(
                                    value['countryCode']!,
                                    height: 20,
                                    width: 30,
                                  ),
                              render: (value) {
                                return Text(value['name']!);
                              },
                            ), // Segundo dropdown
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
