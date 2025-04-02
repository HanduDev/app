import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

class AnimationBuilder {
  final Widget widget;

  AnimationBuilder({required this.widget});

  Page<dynamic> build(BuildContext context, GoRouterState state) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: widget,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }
}
