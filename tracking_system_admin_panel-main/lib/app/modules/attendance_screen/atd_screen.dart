import 'package:flutter/material.dart';
import '../../../styles/styles.dart';
import '../../app.dart';
import 'widget/atd.dart';

// ignore: must_be_immutable
class AtdScreen extends StatelessWidget {
  const AtdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.whiteColor,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TabularFormBuses(),
          ],
        ),
      ),
    );
  }
}
