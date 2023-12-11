import 'package:proyecto/home.dart';
import 'package:proyecto/login_screen.dart';
import 'package:proyecto/splash.dart';

const String SplashRout ="/splash";
const String HomeRoute ="/home";
const String LoginRoute ="/login";

final routes ={
  HomeRoute: (context) => const Home(),
  LoginRoute: (context) =>const LoginScreen(),
  SplashRout: (context) => SplashView()
};