import 'package:flutter/material.dart';
import 'package:larflut/core/utils/route_generator.dart';
import 'package:larflut/core/utils/theme.dart';
import 'package:larflut/screen/login/presentation/pages/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Laravel Flutter',
      theme: ThemeData(
          primaryColor: primaryColor,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home: const LoginScreen(),
      initialRoute: "/login",
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
