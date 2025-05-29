import 'package:app/providers/auth_provider.dart';
import 'package:app/ui/core/shared/chat_field.dart';
import 'package:app/ui/core/shared/primary_button.dart';
import 'package:app/ui/core/shared/shared_header.dart';
import 'package:app/ui/core/themes/app_colors.dart';
import 'package:app/ui/core/themes/font.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';

class ContatoPage extends StatelessWidget {
  const ContatoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthProvider>().user!;

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SharedHeader(
              title: Text(
                "account.contact.send_feedback".i18n(),
                style: Font.primary(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  color: AppColors.white,
                ),
              ),
              onBackPressed: () {
                context.pop();
              },
            ),

            const SizedBox(height: 40),

            Text(
              "account.contact.type_feedback".i18n(),
              style: Font.primary(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.primary500,
              ),
            ),

            const SizedBox(height: 40),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ChatField(
                trianglePosition: ChatFieldPosition.left,
                iconButtonEnabled: false,
                backgroundColor: AppColors.white,
                textColor: AppColors.primary300,
                minHeight: 150,
                label: "common.type_something".i18n(),
              ),
            ),

            const SizedBox(height: 30),

            Hero(
            tag: 'primary-button',
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: PrimaryButton(
                text: "common.send".i18n(),
                fontSize: 20,
                height: 30,
                rounded: true,
                onPressed: (){},
              ),
            ),
          ),
          ],
        ),
      ),
    );
  }
}
