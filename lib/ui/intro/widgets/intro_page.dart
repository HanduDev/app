import 'package:app/ui/intro/view_model/intro_view_model.dart';
import 'package:app/ui/intro/widgets/intro_bottom.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app/ui/core/themes/app_colors.dart';
import 'package:provider/provider.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final List<Widget> items =
      [1, 2, 3].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/carousel_$i.png'),
                ),
              ),
            );
          },
        );
      }).toList();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: AppColors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: AppColors.primary100,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    CarouselSlider(
                      key: Key('Slider'),
                      options: CarouselOptions(
                        height: double.infinity,
                        autoPlay: true,
                        viewportFraction: 1.0,
                        onPageChanged: (index, reason) {
                          context.read<IntroViewModel>().onPageChanged(index);
                        },
                      ),
                      items: items,
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          'assets/images/Logo.png',
                          width: 80,
                          height: 80,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              FractionalTranslation(
                translation: Offset(0, -0.025),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
                  decoration: BoxDecoration(
                    color: AppColors.primary100,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black.withAlpha(130),
                        spreadRadius: 1,
                        blurRadius: 22,
                      ),
                      BoxShadow(
                        color: AppColors.primary100,
                        spreadRadius: 1,
                        offset: Offset(0, 20),
                      ),
                    ],
                  ),
                  child: IntroBottom(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
