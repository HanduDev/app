import 'package:app/ui/core/shared/text_input.dart';
import 'package:app/ui/core/themes/app_colors.dart';
import 'package:app/ui/libras/view_model/libras_view_model.dart';
import 'package:app/ui/core/shared/chat_triangle.dart';
import 'package:app/ui/libras/widgets/vlibras_web_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LibrasPage extends StatelessWidget {
  const LibrasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<LibrasViewModel>(
          builder: (context, viewModel, child) {
            return Stack(
              children: [
                VLibrasWebView(),
                Positioned(
                  bottom: 44,
                  left: 22,
                  right: 22,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.primary400,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      ),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 35,
                          spreadRadius: 5,
                          offset: Offset(0, 0),
                          color: Colors.black.withAlpha(30),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: TextInput(
                                  controller: viewModel.textController,
                                  label: "Digite algo",
                                  textColor: AppColors.white,
                                  borderColor: AppColors.primary400,
                                ),
                              ),
                              const SizedBox(width: 10),
                              IconButton(
                                onPressed: () {
                                  viewModel.sendText();
                                },
                                icon: Icon(Icons.send),
                                color: AppColors.white,
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.mic),
                                color: AppColors.white,
                                padding: EdgeInsets.all(0),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.feedback_outlined),
                                color: AppColors.white,
                                padding: EdgeInsets.all(0),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 44,
                  right: 22,
                  child: CustomPaint(
                    size: Size(30, 20),
                    painter: ChatTriangle(),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
