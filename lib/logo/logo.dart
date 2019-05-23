import 'package:flutter/material.dart';

class LogoApp extends StatefulWidget {
  @override
  _LogoAppState createState() => _LogoAppState();
}

class _LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // vsync tem a ver com com os frames que estao sendo atualizados, assim para cada frame ele irá anima-lo
    _animationController = AnimationController(vsync: this, duration: Duration(seconds: 10));

    _animation = CurvedAnimation(parent: _animationController, curve: Curves.bounceOut)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animationController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _animationController.forward();
        }
      });

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GrowTransition(animation: _animation, child: FlutterLogo());
  }
}

class GrowTransition extends StatelessWidget {
  final Widget child;
  final Animation<double> animation;

  final sizeTween = Tween<double>(begin: 0, end: 300);
  final opacityTween = Tween<double>(begin: 0.1, end: 1.0);

  GrowTransition({this.child, this.animation});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return Opacity(
            opacity: opacityTween.evaluate(animation).clamp(0, 1.0),
            child: Container(
              height: sizeTween.evaluate(animation),
              width: sizeTween.evaluate(animation),
              child: child,
            ),
          );
        },
        child: child,
      ),
    );
  }
}

//class AnimatedLogo extends AnimatedWidget {
//
//    final sizeTween = Tween<double>(begin: 0, end: 300);
//    final opacityTween = Tween<double>(begin: 0.1, end: 1);
//
//
//    AnimatedLogo(Animation<double> _animation) : super(listenable: _animation);
//
//    @override
//    Widget build(BuildContext context) {
//        return Center(
//            child: Container(
//                height: _animation.value,
//                width: _animation.value,
//                child: FlutterLogo(),
//            ),
//        );;
//    }
//
//}
