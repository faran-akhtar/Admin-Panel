import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracking_system_dashboard/app/app.dart';
import 'package:tracking_system_dashboard/styles/colors/colors.dart';

class DrawerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: CustomColors.offWhiteColor,
      // Add your drawer items here
      child: ListView(
        children: [
          const SizedBox(height: 104),
          const Text(
            "  Admin Login",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: CustomColors.blueColor,
            ),
          ),
          const SizedBox(height: 12),
          ListTile(
            title: const Text('Attendance Screen'),
            onTap: () {
              BlocProvider.of<MainScreenCubit>(context).changeWidget(
                id: 0,
              );
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Home Screen'),
            onTap: () {
              BlocProvider.of<MainScreenCubit>(context).changeWidget(
                id: 1,
              );
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Student Register'),
            onTap: () {
              BlocProvider.of<MainScreenCubit>(context).changeWidget(
                id: 2,
              );
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Driver  Register'),
            onTap: () {
              BlocProvider.of<MainScreenCubit>(context).changeWidget(
                id: 3,
              );
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Add Buses'),
            onTap: () {
              BlocProvider.of<MainScreenCubit>(context).changeWidget(
                id: 4,
              );
              Navigator.pop(context);
            },
          ),
          // Add more ListTiles for other items in the drawer
        ],
      ),
    );
  }
}
