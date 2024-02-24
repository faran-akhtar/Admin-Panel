import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracking_system_dashboard/firebase_options.dart';

import 'app/app.dart';
import 'package:flutter/material.dart';
import 'styles/styles.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SignInCubit(context),
        ),
        BlocProvider(
          create: (context) => StudentRegisterCubit(context),
        ),
      ],
      child: MaterialApp(
        scrollBehavior: MyCustomScrollBehavior(),
        debugShowCheckedModeBanner: false,
        title: 'Admin Panel',
        theme: ThemeData(
          scaffoldBackgroundColor: CustomColors.backgroundColor,
        ),
        initialRoute: Routes.initial,
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
