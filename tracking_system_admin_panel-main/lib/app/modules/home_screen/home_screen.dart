import 'package:flutter/material.dart';
import '../../../styles/styles.dart';
import 'google_map.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.whiteColor,
      body: MapScreen(),
    );
  }
}
