import 'package:flutter/material.dart';
import '../../../styles/styles.dart';
import '../../app.dart';
import 'widget/buses.dart';

// ignore: must_be_immutable
class BusesScreen extends StatelessWidget {
  const BusesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.whiteColor,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            BusRegisterDialog(),
            const SizedBox(
              height: 20,
            ),
            TabularFormBuses(),
          ],
        ),
      ),
    );
  }
}
