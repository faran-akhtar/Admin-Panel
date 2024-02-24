import 'package:flutter/material.dart';
import '../../../styles/styles.dart';
import '../../app.dart';
import 'widget/drivers.dart';

class DriverRegister extends StatelessWidget {
  const DriverRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.whiteColor,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            DriverRegisterDialog(),
            const SizedBox(
              height: 20,
            ),
            TabularFormDriver(),
          ],
        ),
      ),
    );
  }
}
