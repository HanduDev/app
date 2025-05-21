import 'package:app/helpers/toast.dart';
import 'package:app/providers/auth_provider.dart';
import 'package:app/routes/routes.dart';
import 'package:app/ui/account/widgets/config_card.dart';
import 'package:app/ui/account/widgets/config_item.dart';
import 'package:app/ui/core/themes/app_colors.dart';
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
                    color: AppColors.white,
                    onPressed: () async {
                      if (!context.mounted) return;

                      final shouldLogout = await showDialog<bool>(
                        context: context,
                        builder:
                            (context) => AlertDialog(
                              backgroundColor: AppColors.white,
                              title: Center(
                                child: const Text(
                                  'Sair',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              content: const Text(
                                'Tem certeza que deseja sair?',
                              ),
                              actionsAlignment: MainAxisAlignment.spaceBetween,
                              actions: [
                                TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: AppColors.white,
                                    foregroundColor: AppColors.primary500,
                                    minimumSize: const Size(100, 40),
                                  ),
                                  onPressed:
                                      () => Navigator.of(context).pop(false),
                                  child: const Text('Não'),
                                ),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: AppColors.primary500,
                                    foregroundColor: AppColors.white,
                                    minimumSize: const Size(120, 40),
                                  ),
                                  onPressed:
                                      () => Navigator.of(context).pop(true),
                                  child: const Text('Sim'),
                                ),
                              ],
                            ),
                      );

                      if (shouldLogout == true) {
                        try {
                          // ignore: use_build_context_synchronously
                          final authProvider = context.read<AuthProvider>();
                          await authProvider.signOut();

                          if (!context.mounted) return;

                          context.pushReplacement(Routes.intro);
                        } catch (e) {
                          if (!context.mounted) return;
                          Toast.error(context, 'Erro ao sair');
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 30),

        ConfigCard(
          widgets: [
            ConfigItem(
              icon: Icons.person_outlined,
              title: 'Perfil',
              onTap: () {
                context.pushReplacement(Routes.editar);
              },
            ),
            ConfigItem(
              icon: Icons.emoji_events_outlined,
              title: 'Conquistas',
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => EmDesenvolvimento(title: 'Conquistas'),
                );
              },
            ),
            ConfigItem(
              icon: Icons.language_outlined,
              title: 'Idioma do App',
              onTap: () {
                showDialog(
                  context: context,
                  builder:
                      (context) => EmDesenvolvimento(title: 'Idioma'),
                );
              },
            ),
            ConfigItem(
              icon: Icons.smartphone_outlined,
              title: 'Permissões do Dispositivo',
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => EmDesenvolvimento(title: 'Permissões do Dispositivo'),
                );
              },
            ),
          ],
        ),

        const SizedBox(height: 40),

        ConfigCard(
          widgets: [
            ConfigItem(
              icon: Icons.contact_support_outlined,
              title: 'Entre em contato',
              onTap: () {
                showDialog(
                  context: context,
                  builder:
                      (context) => EmDesenvolvimento(title: 'Entre em contato'),
                );
              },
            ),
            ConfigItem(
              icon: Icons.lock_outlined,
              title: 'Política de privacidade',
              onTap: () {
                showDialog(
                  context: context,
                  builder:
                      (context) =>
                          EmDesenvolvimento(title: 'Política de privacidade'),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}

// Apagar depois que estiver pronto
class EmDesenvolvimento extends StatelessWidget {
  final String title;

  const EmDesenvolvimento({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.white,
      title: Center(
        child: Text(
          title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      content: const Text('Em desenvolvimento'),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: AppColors.white,
            foregroundColor: AppColors.primary500,
            minimumSize: const Size(100, 40),
          ),
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Fechar'),
        ),
      ],
    );
  }
}
