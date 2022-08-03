import 'package:flutter/material.dart';
import 'package:flutter_test_task/helpers/constants.dart';
import 'package:flutter_test_task/screens/chatsscreen.dart';
import 'package:provider/provider.dart';

import '../helpers/app_provider.dart';

class Splash extends StatefulWidget {
  //const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with TickerProviderStateMixin {
  Animation<double>? _animation;
  AnimationController? _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(
        seconds: 2,
      ),
      vsync: this,
      value: 0.1,
    );
    _controller!.forward();

    _animation = CurvedAnimation(
      parent: _controller!,
      curve: Curves.easeIn,
    );

    Provider.of<AppProvider>(context, listen: false).queryUsertable();

    Future.delayed(Duration(seconds: 3)).then(
        (value) => Navigator.of(context).pushNamed(ChatsScreen.routeName));

    super.initState();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ScaleTransition(
          scale: _animation!,
          alignment: Alignment.center,
          child: Image.asset(
            "assets/images/splash.png",
            height: calculateSize(340),
            width: calculateSize(250),
          ),
        ),
      ),
    );
  }
}
