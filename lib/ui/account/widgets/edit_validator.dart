import 'package:app/helpers/errors.dart';
import 'package:app/helpers/toast.dart';
import 'package:app/providers/auth_provider.dart';
import 'package:app/routes/routes.dart';
import 'package:app/ui/core/shared/primary_button.dart';
import 'package:app/ui/core/shared/text_input.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';

class EditValidator extends StatefulWidget {
  const EditValidator({super.key});

  @override
  EditValidatorState createState() {
    return EditValidatorState();
  }
}

class EditValidatorState extends State<EditValidator> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    final user = context.read<AuthProvider>().user;
    _nameController = TextEditingController(text: user?.fullName ?? '');
    _emailController = TextEditingController(text: user?.email ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> validatedAndSubmit() async {
      try {
        if (!_formKey.currentState!.validate()) return;

        final authProvider = context.read<AuthProvider>();

        await authProvider.updateUser(
          name: _nameController.text,
          email: _emailController.text,
        );

        if (context.mounted) {
          Toast.success(context, 'account.edit.success'.i18n());
          if (_emailController.text != authProvider.user?.email) {
            context.push(Routes.confirmacaoCadastro,
                extra: {'email': _emailController.text});
          }
        }
      } catch (e) {
        if (!context.mounted) return;
        Toast.error(context, getErrorMessage(e));
      }
    }

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextInput(
            keyField: const Key('nameField'),
            controller: _nameController,
            label: 'account.edit.name'.i18n(),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'account.name_validation_required'.i18n();
              }
              return null;
            },
          ),
          const SizedBox(height: 30),

          TextInput(
            keyField: const Key('emailField'),
            controller: _emailController,
            label: 'account.edit.email'.i18n(),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'account.email_validation_required'.i18n();
              }
              if (!RegExp(
                r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
              ).hasMatch(value)) {
                return 'account.email_validator'.i18n();
              }
              return null;
            },
          ),
          const SizedBox(height: 30),

          Hero(
            tag: 'primary-button',
            child: PrimaryButton(
              text: 'common.save'.i18n(),
              rounded: true,
              onPressed: validatedAndSubmit,
              loading: context.watch<AuthProvider>().isAuthenticating,
            ),
          ),
        ],
      ),
    );
  }
}
