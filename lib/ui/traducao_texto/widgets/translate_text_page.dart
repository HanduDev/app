import 'package:app/providers/auth_provider.dart';
import 'package:app/ui/core/shared/chat_field.dart';
import 'package:app/ui/core/shared/dropdown_button.dart';
import 'package:app/ui/core/shared/segmented_control/segmented_control.dart';
import 'package:app/ui/core/shared/segmented_control/segmented_control_item.dart';
import 'package:app/ui/core/themes/app_colors.dart';
import 'package:app/ui/core/themes/font.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class TranslateTextPage extends StatelessWidget {
  const TranslateTextPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController requestController = TextEditingController();
    final TextEditingController responseController = TextEditingController();

    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        return Scaffold(
          backgroundColor: AppColors.white,
          body: Stack(
            children: [
              Container(
                width: double.infinity,
                height: 430,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [AppColors.primary200, AppColors.primary400],
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
              ),
              SingleChildScrollView(
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
                                SizedBox(height: 6),
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
                                      ? NetworkImage(
                                        authProvider.user!.photoURL!,
                                      )
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
                      SizedBox(height: 60),
                      SegmentedControl(
                        initialIndex: 0,
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
                            text: "Áudio",
                            icon: Icons.mic_none_outlined,
                          ),
                          SegmentedControlItem(
                            key: '/image',
                            text: "Imagem",
                            icon: Icons.image_outlined,
                          ),
                        ],
                      ),
                      SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: LanguageSelector(), // Primeiro dropdown
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
                                      color: Colors.black.withValues(
                                        alpha: 300,
                                      ),
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
                            child: LanguageSelector(), // Segundo dropdown
                          ),
                        ],
                      ),
                      SizedBox(height: 48),
                      ChatField(
                        controller: requestController,
                        onSendMessage: (message) {},
                      ),
                      ChatField(
                        controller: responseController,
                        onSendMessage: (message) {},
                        trianglePosition: ChatFieldPosition.left,
                        backgroundColor: AppColors.primary100,
                        textColor: AppColors.primary300,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
