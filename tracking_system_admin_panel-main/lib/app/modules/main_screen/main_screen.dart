import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracking_system_dashboard/app/app.dart';
import 'package:tracking_system_dashboard/app/modules/main_screen/widget/drawer_page.dart';
import '../../../styles/styles.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainScreenCubit(context),
      child: Scaffold(
        backgroundColor: CustomColors.backgroundColor,
        appBar: AppBar(
          title: const Text(
            "UOG Bus Tracking System",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          backgroundColor: CustomColors.skyBlueColor,
          elevation: 0,
          centerTitle: true,
        ),
        drawer: DrawerPage(),
        body: BlocBuilder<MainScreenCubit, MainScreenState>(
          builder: (context, state) => state.widget!,
        ),
      ),
    );
  }
}
