import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:app/ui/core/shared/language_selector.dart';
import 'package:app/ui/core/shared/segmented_control/segmented_control.dart';
import 'package:app/ui/core/shared/segmented_control/segmented_control_item.dart';
import 'package:app/ui/core/themes/app_colors.dart';
import 'package:app/ui/core/shared/dropdown/dropdown_button_controller.dart';
import 'package:go_router/go_router.dart';

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

  final DropdownButtonController fromLanguageController =
      DropdownButtonController();
  final DropdownButtonController toLanguageController =
      DropdownButtonController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _setupCameraController();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    cameraController?.dispose();
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
      print('Erro ao inicializar a câmera: $e');
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
          capturedImage = image; // Armazena a imagem capturada
        });
      } catch (e) {
        print('Erro ao capturar a foto: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          if (capturedImage != null)
            Positioned.fill(
              child: Image.file(
                File(capturedImage!.path),
                fit: BoxFit.cover,
              ),
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
                                controller: fromLanguageController,
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
                                controller: toLanguageController,
                              ),
                            ),
                          ],
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
                        child: const Text("Tirar outra foto"),
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
