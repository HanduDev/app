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
import 'package:localization/localization.dart';
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
    final isLoading = context.select<EducacaoViewModel, bool>(
      (value) => value.isLoading,
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
                                'educacao.title'.i18n(),
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
                text: 'educacao.create_study_plan'.i18n(),
              ),
            ),
            const SizedBox(height: 40),
            Text(
              'educacao.subtitle'.i18n(),
              style: TextStyle(
                fontSize: 18,
                color: AppColors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            Visibility(
              visible: trails.isNotEmpty,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  mainAxisExtent: 130,
                ),
                shrinkWrap: true,
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                physics: const NeverScrollableScrollPhysics(),
                itemCount: trails.length,
                itemBuilder: (context, index) {
                  final trail = trails[index];

                  return CardProgressBar(
                    id: trail.id,
                    title: trail.language.name,
                    countryCode: trail.language.code,
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

            Visibility(
              visible: trails.isEmpty && !isLoading,
              child: Center(child: Text('educacao.no_trails'.i18n())),
            ),

            Visibility(
              visible: isLoading,
              child: const Center(child: CircularProgressIndicator()),
            ),
          ],
        ),
      ),
    );
  }
}
