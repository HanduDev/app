import 'package:app/ui/core/shared/chat_field.dart';
import 'package:app/ui/core/shared/segmented_control/segmented_control.dart';
import 'package:app/ui/core/shared/segmented_control/segmented_control_item.dart';
import 'package:app/ui/core/themes/app_colors.dart';
import 'package:app/ui/core/themes/font.dart';
import 'package:app/ui/libras/view_model/libras_view_model.dart';
import 'package:app/ui/libras/widgets/speech_button.dart';
import 'package:app/ui/libras/widgets/vlibras_web_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class LibrasPage extends StatelessWidget {
  const LibrasPage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<LibrasViewModel>();

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            kIsWeb
                ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      "Seu dispositivo não tem suporte para esta funcionalidade",
                      textAlign: TextAlign.center,
                      style: Font.primary(
                        color: AppColors.grey,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
                : VLibrasWebView(),
            Positioned(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: SegmentedControl(
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
                      text: "Imagem",
                      icon: Icons.image_outlined,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 44,
              left: 22,
              right: 22,
              child: ChatField(
                controller: viewModel.textController,
                onSendMessage: (message) {
                  viewModel.sendText();
                },
                footer: Row(
                  children: [
                    SpeechButton(
                      onRecognize: (value) {
                        viewModel.textController.text = value;
                      },
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.feedback_outlined),
                      color: AppColors.white,
                      padding: EdgeInsets.all(0),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
