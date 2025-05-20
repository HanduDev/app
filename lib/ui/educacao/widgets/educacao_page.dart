import 'package:app/helpers/errors.dart';
import 'package:app/helpers/toast.dart';
import 'package:app/models/trail/trail.dart';
import 'package:app/providers/auth_provider.dart';
import 'package:app/routes/routes.dart';
import 'package:app/ui/core/shared/primary_button.dart';
import 'package:app/ui/core/themes/app_colors.dart';
import 'package:app/ui/educacao/view_model/educacao_view_model.dart';
import 'package:app/ui/educacao/widgets/card_progressbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class EducacaoPage extends StatefulWidget {
  const EducacaoPage({super.key});

  @override
  State<EducacaoPage> createState() => _EducacaoPageState();
}

class _EducacaoPageState extends State<EducacaoPage> {
  String getFirstName(String? fullName) {
    if (fullName == null || fullName.isEmpty) return 'Usuário';
    return fullName.split(' ').first;
  }

  Future<void> fetchData() async {
    try {
      final educacaoViewModel = context.read<EducacaoViewModel>();
      await educacaoViewModel.initialize();
    } catch (e) {
      if (mounted) {
        Toast.error(context, getErrorMessage(e));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.read<AuthProvider>();
    final trails = context.select<EducacaoViewModel, List<Trail>>(
      (value) => value.trails,
    );

    return Scaffold(
      backgroundColor: AppColors.primary100,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 250,
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
                  const SizedBox(height: 50),
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
                                  fontSize: 12,
                                  color: AppColors.yellow,
                                ),
                              ),

                              const SizedBox(height: 6),

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
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: trails.length,
                separatorBuilder: (context, index) => const SizedBox(width: 20),
                itemBuilder: (context, index) {
                  final trail = trails[index];
                  return CardProgressBar(
                    id: trail.id,
                    title: trail.language.name,
                    progress: trail.progress,
                    progressText:
                        '${(trail.progress * 100).toStringAsFixed(0)}%',
                    onTap: () {
                      context.push(Routes.trilha, extra: {'trail': trail});
                    },
                  );
                },
              ),
            ),      
          ],
        ),
      ),
    );
  }
}
