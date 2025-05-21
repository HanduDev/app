import 'package:app/ui/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

void showFeedbackDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      int selectedRating = 0;

      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            title: Text(
              "O que achou da tradução?",
              style: TextStyle(
                fontWeight: FontWeight.normal,
                color: AppColors.black,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return IconButton(
                      onPressed: () {
                        setState(() {
                          selectedRating = index + 1;
                        });
                      },
                      icon: Icon(
                        Icons.star_rounded,
                        color:
                            index < selectedRating
                                ? AppColors.primary500
                                : Colors.grey,
                      ),
                    );
                  }),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Cancelar"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (selectedRating > 0) {
                          Navigator.of(context).pop();
                          showFeedbackCompletedDialog(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Por favor, selecione uma avaliação.",
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary500,
                        foregroundColor: Colors.white,
                      ),
                      child: Text("Enviar"),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

void showFeedbackCompletedDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      Future.delayed(Duration(seconds: 3), () {
        if (context.mounted) {
          Navigator.of(context).pop();
        }
      });

      return AlertDialog(
        title: Text(
          "Obrigado pelo feedback!",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.primary500,
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
        content: Text(
          "Seu feedback foi enviado com sucesso.",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.normal,
            color: AppColors.black,
            fontSize: 14,
          ),
        ),
      );
    },
  );
}
