import 'package:app/providers/auth_provider.dart';
import 'package:app/ui/core/shared/chat_field.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:app/ui/core/shared/language_selector.dart';
import 'package:app/ui/core/shared/segmented_control/segmented_control.dart';
import 'package:app/ui/core/shared/segmented_control/segmented_control_item.dart';
import 'package:app/ui/core/themes/app_colors.dart';
import 'package:app/ui/core/themes/font.dart';
import 'package:app/ui/traducao_texto/view_model/translate_text_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class TranslateTextPage extends StatelessWidget {
  TranslateTextPage({super.key});

  final TextEditingController requestController = TextEditingController();
  final TextEditingController responseController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().user;
    final viewModel = context.read<TranslateTextViewModel>();

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
                            controller: viewModel.fromlanguageController,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: GestureDetector(
                            onTap: () {
                              viewModel.swapLanguages();
                            },
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
                            controller: viewModel.tolanguageController,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40),
                  ChatField(
                    controller: requestController,
                    onSendMessage: (message) async {
                      responseController.text = await viewModel.translateText(
                        message,
                      );
                    },
                    label: 'Digite algo',
                    minHeight: 150,
                  ),
                  ChatField(
                    controller: responseController,
                    onSendMessage: (message) {},
                    trianglePosition: ChatFieldPosition.left,
                    isWritable: false,
                    iconButtonEnabled: false,
                    backgroundColor: AppColors.primary100,
                    textColor: AppColors.primary300,
                    minHeight: 145,
                    footer: Row(
                      children: [
                        IconButton(
                          onPressed: () async {
                            if (responseController.text.isNotEmpty) {
                              final flutterTts = FlutterTts();
                              await flutterTts.speak(responseController.text);
                            }
                          },
                          icon: Icon(Icons.volume_up_outlined),
                          color: AppColors.primary500,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.feedback_outlined),
                          color: AppColors.primary500,
                        ),
                        IconButton(
                          onPressed: () {
                            Clipboard.setData(
                              ClipboardData(text: responseController.text),
                            );
                          },
                          icon: Icon(Icons.copy),
                          color: AppColors.primary500,
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
  }
}
