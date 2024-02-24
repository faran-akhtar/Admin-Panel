import 'package:flutter/material.dart';
import '../../../styles/styles.dart';
import '../../../utils/utils_export.dart';
import '../../app.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _animation = Tween<double>(begin: -1.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _animationController.repeat(reverse: true);

    goToLoginScreen();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void goToLoginScreen() {
    Future.delayed(const Duration(seconds: 5)).then((value) {
      Navigator.pushReplacementNamed(
        context,
        Routes.signIn,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.blueColor,
      body: SafeArea(
        child: Center(
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(_animation.value * 10, 0),
                child: Opacity(
                  opacity: 1 - (_animation.value.abs() * 0.5),
                  child: child,
                ),
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 400,
                  child: Image.network(
                    'assets/images/logo.png',
                    fit: BoxFit.fill,
                  ),
                ),
                const Text(
                  'UOG Bus Tracking System',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
