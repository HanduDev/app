import 'dart:io';
import 'package:app/helpers/errors.dart';
import 'package:app/helpers/toast.dart';
import 'package:app/models/language.dart';
import 'package:app/providers/languages_provider.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:app/ui/core/shared/language_selector.dart';
import 'package:app/ui/core/shared/segmented_control/segmented_control.dart';
import 'package:app/ui/core/shared/segmented_control/segmented_control_item.dart';
import 'package:app/ui/core/themes/app_colors.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:go_router/go_router.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';
import 'package:app/ui/translate_image/view_model/translate_image_view_model.dart';
import 'package:app/ui/core/shared/chat_field.dart';

class TranslateImagePage extends StatefulWidget {
  const TranslateImagePage({super.key});

  @override
  State<TranslateImagePage> createState() => _TranslateImagePageState();
}

class _TranslateImagePageState extends State<TranslateImagePage>
    with WidgetsBindingObserver {
  List<CameraDescription> cameras = [];
  CameraController? cameraController;
  bool isCameraInitialized = false;
  XFile? capturedImage;
  String? translatedText;
  bool isTranslating = false;
  late TextEditingController responseController;
  late FlutterTts flutterTts;

  @override
  void initState() {
    super.initState();
    responseController = TextEditingController();
    flutterTts = FlutterTts();
    _initTts();
    WidgetsBinding.instance.addObserver(this);
    _setupCameraController();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    cameraController?.dispose();
    responseController.dispose();
    flutterTts.stop();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (cameraController == null || !cameraController!.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused) {
      cameraController?.dispose();
      cameraController = null;
    } else if (state == AppLifecycleState.resumed) {
      _setupCameraController();
    }
  }

  Future<void> _setupCameraController() async {
    if (cameraController != null && cameraController!.value.isInitialized) {
      return;
    }

    try {
      cameras = await availableCameras();
      if (cameras.isNotEmpty) {
        cameraController = CameraController(
          cameras.first,
          ResolutionPreset.high,
        );

        await cameraController?.initialize();
        if (mounted) {
          setState(() {
            isCameraInitialized = true;
          });
        }
      }
    } catch (e) {
      if (mounted) {
        Toast.error(context, getErrorMessage(e));
      }
      setState(() {
        isCameraInitialized = false;
      });
    }
  }

  Future<void> _capturePhoto() async {
    if (cameraController != null && cameraController!.value.isInitialized) {
      try {
        final image = await cameraController!.takePicture();
        setState(() {
          capturedImage = image;
        });
      } catch (e) {
        if (mounted) {
          Toast.error(context, getErrorMessage(e));
        }
      }
    }
  }

  Future<void> _handleTranslation() async {
    if (capturedImage != null) {
      setState(() {
        isTranslating = true;
      });

      try {
        final viewModel = context.read<TranslateImageViewModel>();
        final result = await viewModel.translateImage(capturedImage!);
        setState(() {
          translatedText = result;
          isTranslating = false;
        });
      } catch (e) {
        setState(() {
          translatedText = 'translate_image.network_error'.i18n();
          isTranslating = false;
        });
      }
    }
  }

  Future<void> _initTts() async {
    await flutterTts.setLanguage("pt-BR");
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setVolume(1.0);
    await flutterTts.setPitch(1.0);
  }

  Future<void> speakText(String text) async {
    if (text.isNotEmpty) {
      try {
        await flutterTts.speak(text);
      } catch (e) {
        if (mounted) {
          Toast.error(context, getErrorMessage(e));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<TranslateImageViewModel>();

    final initialLanguage = context.select<LanguagesProvider, Language?>(
      (value) => value.defaultLanguage,
    );

    return Scaffold(
      body: Stack(
        children: [
          if (capturedImage != null)
            Positioned.fill(
              child: Image.file(File(capturedImage!.path), fit: BoxFit.cover),
            )
          else if (isCameraInitialized && cameraController != null)
            Positioned.fill(child: CameraPreview(cameraController!))
          else
            const Center(child: CircularProgressIndicator()),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  SizedBox(height: 80),
                  Hero(
                    tag: 'segmented',
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SegmentedControl(
                        initialIndex: 2,
                        onChange: (value) {
                          context.go(value);
                        },
                        items: [
                          SegmentedControlItem(
                            key: '/home',
                            text: "segmented_control.text".i18n(),
                            icon: Icons.text_snippet_outlined,
                          ),
                          SegmentedControlItem(
                            key: '/audio',
                            text: "segmented_control.audio".i18n(),
                            icon: Icons.mic_none_outlined,
                          ),
                          SegmentedControlItem(
                            key: '/image',
                            text: "segmented_control.image".i18n(),
                            icon: Icons.image_outlined,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 32),
                  if (capturedImage != null)
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Hero(
                        tag: "dropdown-languages",
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: LanguageSelector(
                                controller: viewModel.fromlanguageController,
                                initialValue: initialLanguage,
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
                              child: LanguageSelector(
                                controller: viewModel.tolanguageController,
                                onChanged: (_) => _handleTranslation(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  if (isTranslating)
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: CircularProgressIndicator(),
                    )
                  else if (translatedText != null)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ChatField(
                          controller:
                              responseController..text = translatedText!,
                          onSendMessage: (message) {},
                          isWritable: false,
                          iconButtonEnabled: false,
                          backgroundColor: AppColors.white,
                          textColor: AppColors.black,
                          minHeight: 100,
                          footer: Row(
                            children: [
                              IconButton(
                                onPressed: () async {
                                  if (translatedText != null &&
                                      translatedText!.isNotEmpty) {
                                    try {
                                      await flutterTts.speak(translatedText!);
                                    } catch (e) {
                                      if (context.mounted) {
                                        Toast.error(
                                          context,
                                          getErrorMessage(e),
                                        );
                                      }
                                    }
                                  }
                                },
                                icon: Icon(Icons.volume_up_outlined),
                                color: AppColors.primary500,
                              ),

                              IconButton(
                                onPressed: () {
                                  if (translatedText != null) {
                                    Clipboard.setData(
                                      ClipboardData(text: translatedText!),
                                    );
                                  }
                                },
                                icon: Icon(Icons.copy),
                                color: AppColors.primary500,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  const Spacer(),
                  if (capturedImage != null)
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            capturedImage = null;
                            translatedText = null;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary500,
                          foregroundColor: Colors.white,
                          shape: const StadiumBorder(),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24.0,
                            vertical: 12.0,
                          ),
                        ),
                        child: Text(
                          "translate_image.take_another_photo".i18n(),
                        ),
                      ),
                    )
                  else
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                        onPressed: _capturePhoto,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary500,
                          foregroundColor: Colors.white,
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(16.0),
                        ),
                        child: const Icon(Icons.camera_alt, size: 32),
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
