import 'package:app/helpers/toast.dart';
import 'package:app/providers/auth_provider.dart';
import 'package:app/routes/routes.dart';
import 'package:app/ui/account/widgets/config_card.dart';
import 'package:app/ui/account/widgets/config_item.dart';
import 'package:app/ui/core/shared/primary_button.dart';
import 'package:app/ui/core/themes/app_colors.dart';
import 'package:app/ui/core/themes/font.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

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
              child:             
              Padding(
                padding: const EdgeInsets.only(top: 100,),
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage:
                      user.photoURL != null ? NetworkImage(user.photoURL!) : null,
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
          Positioned(
            left: 230,
            top: 110.5,
            child: Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.white,
                border: Border.all(
                  color: Colors.white,
                  width: 5,
                ),
              ),
              child: Center(
                child: IconButton(
                  icon: const Icon(Icons.edit_outlined),
                  color: AppColors.black,
                  onPressed: () {},
                ),
              ),
            ),
          ),
        Positioned(
            top: 42,
            left: 24,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.notifications_outlined, size: 31),
                  color: Colors.white,
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.logout_outlined, size: 31),
                  color: Colors.white,
                  onPressed: () async {
                    try {
                      final authProvider = context.read<AuthProvider>();
                      await authProvider.signOut();

                      if (!context.mounted) return;

                      context.pushReplacement(Routes.intro);
                      } catch (e) {
                      if (!context.mounted) return;
                      Toast.error(context, 'Erro ao sair');
                    }
                    },
                ),
              ],
            ),
          ),
        ],
        ),
        
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
        Text(
          user.fullName,
          style: Font.primary(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.primary500,
          )
        ),

        const SizedBox(height: 20),
        
        ConfigCard(widgets: [
          ConfigItem(
            icon: Icons.settings_outlined,
            title: 'Configurações',
            onTap: () {},
          ),
          ConfigItem(
            icon: Icons.emoji_events_outlined,
            title: 'Conquistas',
            onTap: () {},
          ),
          ConfigItem(
            icon: Icons.notifications_outlined,
            title: 'Notificações',
            onTap: () {},
          ),
          ConfigItem(
            icon: Icons.translate_outlined,
            title: 'Linguagem',
            onTap: () {},
          ),
        ]),
        
        const SizedBox(height: 40),
        
        ConfigCard(widgets: [
          ConfigItem(
            icon: Icons.contact_support_outlined,
            title: 'Entre em contato',
            onTap: () {},
          ),
          ConfigItem(
            icon: Icons.lock_outlined,
            title: 'Política de privacidade',
            onTap: () {},
          ),
        ]),
        
        const SizedBox(height: 40),
        
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: PrimaryButton(
            rounded: true,
            onPressed: () {
             
            },
            leftIcon: Icon(Icons.delete_outlined, size: 26),
            text: "Excluir conta",
            ),
          ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}