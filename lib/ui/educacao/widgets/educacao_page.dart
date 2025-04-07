import 'package:app/providers/auth_provider.dart';
import 'package:app/ui/core/shared/primary_button.dart';
import 'package:app/ui/core/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EducacaoPage extends StatelessWidget {
  const EducacaoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        return Scaffold(
            backgroundColor: AppColors.primary100,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: 430,
                    height: 344,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [
                          AppColors.primary200,
                          AppColors.primary400,
                        ],
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(64),
                        bottomRight: Radius.circular(64),
                      ),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 90,),
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
                                
                                    const SizedBox(height: 5,),
                                
                                    Text(
                                      authProvider.user?.fullName ?? 'Usuário da Silva Campos',
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
                              width: 200,
                              height: 200,
                              ),
                          ],
                        )
                      ],
                    ),
                  ),

                  const SizedBox(height: 30,),

                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 20),
                   child: PrimaryButton(
                      rounded: true,
                      onPressed: () {
                        //; Colocar uma ação aquia
                      },
                      leftIcon: Icon(Icons.add_outlined, size: 25,),
                      text: 'Criar Plano de Estudos',
                    ),
                 ),

                const SizedBox(height: 40,),

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
                
                const SizedBox(height: 30,),

                // Criar o widget de cards de planos de estudos

                ],
                ),
              ),
          );
      }
    );
  }
}
