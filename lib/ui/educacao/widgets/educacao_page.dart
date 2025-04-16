import 'package:app/providers/auth_provider.dart';
import 'package:app/routes/routes.dart';
import 'package:app/ui/core/shared/primary_button.dart';
import 'package:app/ui/core/themes/app_colors.dart';
import 'package:app/ui/educacao/widgets/card_progressbar.dart';
import 'package:app/ui/educacao/widgets/card_recommendation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class EducacaoPage extends StatelessWidget {
  const EducacaoPage({super.key});

  String getFirstName(String? fullName) {
    if (fullName == null || fullName.isEmpty) return 'Usuário';
    return fullName.split(' ').first;
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.read<AuthProvider>();

    return Scaffold(
      backgroundColor: AppColors.primary100,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [AppColors.primary200, AppColors.primary400],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(64),
                  bottomRight: Radius.circular(64),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 90),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'O que deseja aprender hoje,',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: AppColors.yellow,
                                ),
                              ),

                              const SizedBox(height: 5),

                              Text(
                                getFirstName(authProvider.user?.fullName),
                                style: TextStyle(
                                  fontSize: 30,
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                softWrap: true,
                                overflow: TextOverflow.visible,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Image.asset(
                        'assets/images/educacao_avatar.png',
                        width: 175,
                        height: 200,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: PrimaryButton(
                rounded: true,
                onPressed: () {
                  context.push(Routes.planoDeEstudos);
                },
                leftIcon: Icon(Icons.add_outlined, size: 25),
                text: 'Criar Plano de Estudos',
              ),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.only(right: 80),
              child: Text(
                'Continuar planos de estudos',
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  CardProgressBar(
                    title: 'Libras',
                    progress: 0.5,
                    progressText: '50%',
                  ),
                  const SizedBox(width: 20),
                  CardProgressBar(
                    title: 'Inglês',
                    progress: 0.7,
                    progressText: '70%',
                  ),
                  const SizedBox(width: 20),
                  CardProgressBar(
                    title: 'Espanhol',
                    progress: 1.0,
                    progressText: '100%',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(right: 185),
              child: Text(
                'Recomendações',
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  CardRecommendation(
                    language: {'name': 'Brasil', 'countryCode': 'pt-br'}, 
                    level: 'Iniciante', 
                    persons: 120,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
