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
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TranslateAudioPage extends StatefulWidget {
  const TranslateAudioPage({super.key});

  @override
  State<TranslateAudioPage> createState() => _TranslateAudioPageState();
}

class _TranslateAudioPageState extends State<TranslateAudioPage> {
  final TextEditingController requestController = TextEditingController();
  final TextEditingController responseController = TextEditingController();
  final DropdownButtonController fromLanguageController =
      DropdownButtonController();
  final DropdownButtonController toLanguageController =
      DropdownButtonController();
  late FlutterTts flutterTts;

  @override
  void initState() {
    super.initState();
    flutterTts = FlutterTts();
    // Sincronizar os controladores com o ViewModel
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = context.read<TranslateTextViewModel>();
      fromLanguageController.value = viewModel.fromlanguageController.value;
      toLanguageController.value = viewModel.tolanguageController.value;
    });
  }

  @override
  void dispose() {
    requestController.dispose();
    responseController.dispose();
    flutterTts.stop();
    super.dispose();
  }

  Future<void> _speakText(String text) async {
    if (text.isNotEmpty) {
      await flutterTts.setLanguage(toLanguageController.value.code);
      await flutterTts.speak(text);
    }
  }

  Future<void> _translateText(String text) async {
    if (fromLanguageController.value == null ||
        toLanguageController.value == null) {
      if (mounted) {
        setState(() {
          responseController.text =
              'Por favor, selecione os idiomas de origem e destino';
        });
      }
      return;
    }

    if (text.trim().isEmpty) {
      if (mounted) {
        setState(() {
          responseController.text = 'Por favor, fale algo para traduzir';
        });
      }
      return;
    }

    if (mounted) {
      setState(() {
        responseController.text = 'Traduzindo...';
      });
    }

    try {
      final viewModel = context.read<TranslateTextViewModel>();
      viewModel.fromlanguageController.value = fromLanguageController.value;
      viewModel.tolanguageController.value = toLanguageController.value;

      final translatedText = await viewModel.translateText(text);
      if (mounted) {
        setState(() {
          responseController.text = translatedText;
        });
        // Reproduzir áudio automaticamente após a tradução
        await _speakText(translatedText);
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          responseController.text =
              'Erro ao traduzir. Por favor, tente novamente.';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().user;
    final viewModel = context.watch<TranslateTextViewModel>();

    return GradientBackground(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: SingleChildScrollView(
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
                          "common.greetings".i18n(),
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
                        controller: fromLanguageController,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: GestureDetector(
                        onTap: () {
                          viewModel.swapLanguages();
                          final temp = fromLanguageController.value;
                          fromLanguageController.value =
                              toLanguageController.value;
                          toLanguageController.value = temp;
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withAlpha(26),
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
                      child: LanguageSelector(controller: toLanguageController),
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
                        await _translateText(message);
                      },
                      label: 'Fale algo...',
                      minHeight: 100,
                      isWritable: false,
                      iconButtonEnabled: false,
                    ),
                    SpeechButton(
                      onRecognize: (value) async {
                        if (fromLanguageController.value == null ||
                            toLanguageController.value == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Por favor, selecione os idiomas de origem e destino',
                              ),
                              backgroundColor: AppColors.error,
                            ),
                          );
                          return;
                        }
                        setState(() {
                          requestController.text = value;
                        });
                        await _translateText(value);
                      },
                      size: 85.0,
                      backgroundColor:
                          fromLanguageController.value == null ||
                                  toLanguageController.value == null
                              ? AppColors.primary300
                              : AppColors.primary500,
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
                      footer: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed:
                                () => _speakText(responseController.text),
                            icon: Icon(Icons.volume_up_outlined),
                            color: AppColors.primary500,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
