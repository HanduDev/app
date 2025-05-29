import 'package:app/helpers/errors.dart';
import 'package:app/helpers/toast.dart';
import 'package:app/routes/routes.dart';
import 'package:app/ui/libras/image/view_model/libras_image_view_model.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:app/ui/core/shared/segmented_control/segmented_control.dart';
import 'package:app/ui/core/shared/segmented_control/segmented_control_item.dart';
import 'package:app/ui/core/themes/app_colors.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:go_router/go_router.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';
import 'package:app/ui/core/shared/chat_field.dart';

class LibrasImagePage extends StatefulWidget {
  const LibrasImagePage({super.key});

  @override
  State<LibrasImagePage> createState() => _LibrasTextPageState();
}

class _LibrasTextPageState extends State<LibrasImagePage>
    with WidgetsBindingObserver {
  String? translatedText;
  bool isTranslating = false;
  LibrasImageViewModel? viewModel;

  final TextEditingController responseController = TextEditingController();
  final FlutterTts flutterTts = FlutterTts();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    viewModel ??= context.read<LibrasImageViewModel>();
  }

  @override
  void dispose() {
    super.dispose();
    viewModel?.disposeCamera();
    responseController.dispose();
    flutterTts.stop();
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

  Future<void> _initialize(BuildContext context) async {
    await context.read<LibrasImageViewModel>().initialize();
    await _initTts();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<LibrasImageViewModel>();

    return FutureBuilder(
      future: _initialize(context),
      builder: (context, snapshot) {
        return Scaffold(
          body: Stack(
            children: [
              if (viewModel.cameraController?.value.isInitialized ?? false)
                Positioned.fill(
                  child: CameraPreview(viewModel.cameraController!),
                )
              else
                const Center(child: CircularProgressIndicator()),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      SizedBox(height: 80),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SegmentedControl(
                          initialIndex: 1,
                          onChange: (value) {
                            context.go(value);
                          },
                          items: [
                            SegmentedControlItem(
                              key: Routes.librasText,
                              text: "segmented_control.text".i18n(),
                              icon: Icons.text_snippet_outlined,
                            ),
                            SegmentedControlItem(
                              key: Routes.librasImage,
                              text: "segmented_control.image".i18n(),
                              icon: Icons.image_outlined,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 32),
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
                                          await flutterTts.speak(
                                            translatedText!,
                                          );
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
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            TweenAnimationBuilder<double>(
                              tween: Tween<double>(
                                begin: 0,
                                end: viewModel.progress,
                              ),
                              duration: const Duration(milliseconds: 300),
                              builder: (context, value, child) {
                                return SizedBox(
                                  width: 80,
                                  height: 80,
                                  child: CircularProgressIndicator(
                                    value: value,
                                    strokeWidth: 6,
                                    backgroundColor: Colors.grey[300],
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      AppColors.error,
                                    ),
                                  ),
                                );
                              },
                            ),
                            ElevatedButton(
                              onPressed: viewModel.toggleRecording,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary500,
                                foregroundColor: Colors.white,
                                shape: const CircleBorder(),
                                padding: const EdgeInsets.all(16.0),
                                elevation: 4,
                              ),
                              child:
                                  viewModel.isRecording
                                      ? const Icon(Icons.stop, size: 32)
                                      : const Icon(Icons.camera_alt, size: 32),
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
  }
}
