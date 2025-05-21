import 'package:app/providers/auth_provider.dart';
import 'package:app/ui/core/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountEditPage extends StatelessWidget {
  const AccountEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthProvider>().user!;

    return Column(
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
              child: Padding(
                padding: const EdgeInsets.only(top: 100),
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
            ),
          ],
        ),
      ],
    );
  }
}
