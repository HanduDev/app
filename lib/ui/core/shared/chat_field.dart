import 'package:app/ui/core/shared/chat_triangle.dart';
import 'package:app/ui/core/shared/text_input.dart';
import 'package:app/ui/core/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'dart:math';

abstract class ChatFieldPosition {
  static const String right = "right";
  static const String left = "left";
}

class ChatField extends StatelessWidget {
  final TextEditingController? controller;
  final Function(String)? onSendMessage;
  final Function(String)? onTextFieldChanged;
  final double minHeight;
  final String trianglePosition;
  final Widget footer;
  final Color? backgroundColor;
  final Color? textColor;

  const ChatField({
    super.key,
    this.controller,
    this.onTextFieldChanged,
    this.onSendMessage,
    this.minHeight = 116.0,
    this.trianglePosition = ChatFieldPosition.right,
    this.footer = const SizedBox(),
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    bool isRight = trianglePosition == ChatFieldPosition.right;
    Color color = backgroundColor ?? AppColors.primary400;
    Color textColor = this.textColor ?? AppColors.white;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment:
          isRight ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          constraints: BoxConstraints(minHeight: minHeight),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
              bottomLeft: isRight ? Radius.circular(12) : Radius.circular(0),
              bottomRight: isRight ? Radius.circular(0) : Radius.circular(12),
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
          child: Column(
            children: [
              Row(
                children: [
                  Flexible(
                    child: TextInput(
                      keyboardType: TextInputType.multiline,
                      controller: controller,
                      label: "Digite algo",
                      textColor: textColor,
                      borderColor: color,
                      color: color,
                      maxLines: 3,
                      minLines: 1,
                    ),
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      if (onSendMessage != null && controller != null) {
                        onSendMessage!(controller!.text);
                      }
                    },
                    icon: Icon(Icons.send),
                    color: textColor,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              footer,
            ],
          ),
        ),
        Transform.translate(
          offset: Offset(0, -12),
          child: Transform(
            transform: isRight ? Matrix4.rotationZ(pi) : Matrix4.rotationX(pi),
            alignment: isRight ? Alignment.center : Alignment.centerLeft,
            child: CustomPaint(
              size: Size(60, 40),
              painter: ChatTriangle(color: color, borderRadius: 15.0),
            ),
          ),
        ),
      ],
    );
  }
}
