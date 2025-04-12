import 'package:app/providers/auth_provider.dart';
import 'package:app/ui/core/shared/chat_field.dart';
import 'package:app/ui/core/shared/dropdown/dropdown_button_controller.dart';
import 'package:app/ui/core/shared/language_selector.dart';
import 'package:app/ui/core/shared/segmented_control/segmented_control.dart';
import 'package:app/ui/core/shared/segmented_control/segmented_control_item.dart';
import 'package:app/ui/core/themes/app_colors.dart';
import 'package:app/ui/core/themes/font.dart';
import 'package:app/providers/languages_provider.dart';
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
        return Consumer<LanguagesProvider>(
          builder: (context, languagesProvider, child) {
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
                                      authProvider.user?.fullName
                                              .split(' ')
                                              .first ??
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
                                          ? NetworkImage(
                                            authProvider.user!.photoURL!,
                                          )
                                          : null,
                                  backgroundColor: AppColors.primary100,
                                  child:
                                      authProvider.user?.photoURL == null
                                          ? Icon(
                                            Icons.person,
                                            size: 30,
                                            color: AppColors.white,
                                          )
                                          : null,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 40),
                          Hero(
                            tag: 'segmented',
                            child: SegmentedControl(
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
                                Flexible(
                                  child: LanguageSelector(
                                    width: double.infinity,
                                    controller: DropdownButtonController(),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0,
                                  ),
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      padding: const EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.swap_horiz,
                                        color: AppColors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: LanguageSelector(
                                    width: double.infinity,
                                    controller: DropdownButtonController(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 40),
                          ChatField(
                            controller: requestController,
                            onSendMessage: (message) {},
                            minHeight: 150,
                          ),
                          ChatField(
                            controller: responseController,
                            onSendMessage: (message) {},
                            trianglePosition: ChatFieldPosition.left,
                            backgroundColor: AppColors.primary100,
                            textColor: AppColors.primary300,
                            minHeight: 145,
                            footer: Row(
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.volume_up_outlined),
                                  color: AppColors.primary500,
                                  padding: EdgeInsets.fromLTRB(
                                    38.0,
                                    42.0,
                                    0,
                                    0,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.feedback_outlined),
                                  color: AppColors.primary500,
                                  padding: EdgeInsets.fromLTRB(0, 42.0, 0, 0),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.copy),
                                  color: AppColors.primary500,
                                  padding: EdgeInsets.fromLTRB(
                                    0,
                                    42.0,
                                    38.0,
                                    0,
                                  ),
                                ),
                              ],
                            ),
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
      },
    );
  }
}
