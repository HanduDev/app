import 'package:app/providers/auth_provider.dart';
import 'package:app/ui/core/shared/chat_field.dart';
import 'package:app/ui/core/shared/dropdown/dropdown_button_controller.dart';
import 'package:app/ui/core/shared/gradient_background.dart';
import 'package:app/ui/core/shared/language_selector.dart';
import 'package:app/ui/core/shared/segmented_control/segmented_control.dart';
import 'package:app/ui/core/shared/segmented_control/segmented_control_item.dart';
import 'package:app/ui/core/themes/app_colors.dart';
import 'package:app/ui/libras/widgets/speech_button.dart';
import 'package:app/ui/core/themes/font.dart';
import 'package:app/ui/traducao_texto/view_model/translate_text_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class TranslateAudioPage extends StatelessWidget {
  TranslateAudioPage({super.key});
  final TextEditingController requestController = TextEditingController();
  final TextEditingController responseController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().user;

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
                        user?.fullName.split(' ').first ?? '',
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
                        user?.photoURL != null
                            ? NetworkImage(user!.photoURL!)
                            : null,
                    backgroundColor: AppColors.primary100,
                    child:
                        user?.photoURL == null
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
                    key: '/image',
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
                    child: LanguageSelector(
                      controller: DropdownButtonController(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: GestureDetector(
                      onTap: () {},
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
                          Icons.swap_horiz,
                          color: AppColors.primary400,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: LanguageSelector(
                      controller: DropdownButtonController(),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  SizedBox(height: 12),
                  ChatField(
                    controller: requestController,
                    onSendMessage: (message) async {
                      final viewmodel = context.read<TranslateTextViewModel?>();
                      if (viewmodel == null) {
                        return;
                      }
                      responseController.text = await viewmodel.translateText(
                        message,
                      );
                    },
                    label: 'Fale algo...',
                    minHeight: 100,
                  ),
                  SpeechButton(
                    onRecognize: (value) {
                      requestController.text = value;
                    },
                    size: 85.0,
                    backgroundColor: AppColors.primary500,
                  ),
                  SizedBox(height: 32),
                  ChatField(
                    controller: responseController,
                    onSendMessage: (message) {},
                    trianglePosition: ChatFieldPosition.left,
                    isWritable: false,
                    iconButtonEnabled: false,
                    backgroundColor: AppColors.primary100,
                    textColor: AppColors.primary300,
                    minHeight: 100,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
