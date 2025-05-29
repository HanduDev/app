import 'package:app/routes/routes.dart';
import 'package:app/ui/core/shared/chat_field.dart';
import 'package:app/ui/core/shared/segmented_control/segmented_control.dart';
import 'package:app/ui/core/shared/segmented_control/segmented_control_item.dart';
import 'package:app/ui/core/themes/app_colors.dart';
import 'package:app/ui/core/themes/font.dart';
import 'package:app/ui/libras/text/view_model/libras_view_model.dart';
import 'package:app/ui/libras/text/widgets/speech_button.dart';
import 'package:app/ui/libras/text/widgets/vlibras_web_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:localization/localization.dart';

class LibrasTextPage extends StatelessWidget {
  const LibrasTextPage({super.key});

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
                      "libras.device_not_supported".i18n(),
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
                  initialIndex: 0,
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
                      size: 45.0,
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
