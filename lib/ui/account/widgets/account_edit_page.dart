import 'package:app/providers/auth_provider.dart';
import 'package:app/routes/routes.dart';
import 'package:app/ui/account/widgets/edit_validator.dart';
import 'package:app/ui/core/shared/flat_button.dart';
import 'package:app/ui/core/themes/app_colors.dart';
import 'package:app/ui/core/themes/font.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';

class AccountEditPage extends StatelessWidget {
  const AccountEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthProvider>().user!;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 130,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/appbar.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(top: 100, left: 40, right: 40),
                    child: Column(
                      children: [
                        SizedBox(
                          child: CircleAvatar(
                            radius: 60,
                            backgroundImage:
                                user.photoURL != null
                                    ? NetworkImage(user.photoURL!)
                                    : null,
                            backgroundColor: AppColors.primary100,
                            child:
                                user.photoURL == null
                                    ? Icon(
                                      Icons.person_outlined,
                                      size: 60,
                                      color: AppColors.white,
                                    )
                                    : null,
                          ),
                        ),

                        const SizedBox(height: 10),

                        Text(
                          user.fullName,
                          style: Font.primary(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary500,
                          ),
                        ),

                        const SizedBox(height: 30),

                        EditValidator(),

                        const SizedBox(height: 20),

                        FlatButton(
                          text: 'common.cancel'.i18n(),
                          onPressed: () {
                            context.pushReplacement(Routes.conta);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Positioned(
                left: 200,
                bottom: 350,
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.white,
                    border: Border.all(color: Colors.white, width: 5),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.edit_outlined),
                    color: AppColors.black,
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
