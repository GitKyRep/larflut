import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:larflut/core/utils/route_generator.dart';
import 'package:larflut/core/utils/theme.dart';
import 'package:larflut/screen/login/presentation/pages/login_screen.dart';
import 'package:larflut/screen/register/presentation/blocs/register/register_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());

  configLoading();
}

//config library easy loading
void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.red
    ..backgroundColor = Colors.grey
    ..indicatorColor = Colors.red
    ..textColor = Colors.white
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = false
    ..dismissOnTap = false;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RegisterBloc>(
          create: (context) => RegisterBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Laravel Flutter',
        theme: ThemeData(
            primaryColor: primaryColor,
            visualDensity: VisualDensity.adaptivePlatformDensity),
        home: const LoginScreen(),
        initialRoute: "/login",
        onGenerateRoute: RouteGenerator.generateRoute,
        builder: EasyLoading.init(),
      ),
    );
  }
}
