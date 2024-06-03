import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:proyecto/login_screen.dart';
import 'package:proyecto/onboardig.dart';
import 'package:proyecto/provider/test_provider.dart';
import 'package:proyecto/routes.dart';
import 'package:proyecto/services/local_storage.dart';
import 'package:proyecto/services/notificacion_services.dart';
import 'package:proyecto/services/task_provider.dart';
import 'package:proyecto/splash.dart';

int? initScreen = 0;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); //Practica 3
  //await Firebase.initializeApp();
  await LocalStorage.configurePrefs(); //Practica 3
  initScreen = await LocalStorage.prefs.getInt('initScreen');
  await LocalStorage.prefs.setInt('initScreen', 1);
  NotificationService().initNotification();
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => TaskProvider()),
          ChangeNotifierProvider(create: (_) => TestProvider())
    ], child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
        dark: ThemeData.dark(),
        light: ThemeData.light(),
        initial: AdaptiveThemeMode.light, //Practica 3
        builder: (theme, darkTheme) {
          return MaterialApp(
            title: 'Food App',
            theme: theme,
            darkTheme: darkTheme,
            initialRoute:
                initScreen == 0 || initScreen == 1 ? 'onboard' : 'login',
            routes: {
              'onboard': (context) => Onboarding(),
              'login': (context) => SplashView()
            },
          );
        });
  }
}
