import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

enum AniProp {
  opacity,
  translateY,
}

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  FadeAnimation(this.delay, this.child);

  @override
  Widget build(BuildContext context) {
    final tween = MovieTween()
    .scene(begin: Duration.zero, end: Duration(milliseconds: 500))
          .tween(AniProp.opacity, Tween(begin: 0.0, end: 1.0))
          .tween(AniProp.translateY, Tween(begin: -30.0, end: 0.0), curve: Curves.easeOut);

    return PlayAnimationBuilder<Movie>(
        delay: Duration(milliseconds: (500 * delay).round()),
        duration: tween.duration,
        tween: tween.parent,
        child: child,
        builder: (context, value, child) => Opacity(
              opacity: value.get<double>(AniProp.opacity),
              child: Transform.translate(
                  offset: Offset(0, value.get<double>(AniProp.translateY)),
                  child: child),
            ));
  }
}
