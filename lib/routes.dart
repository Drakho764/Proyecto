import 'package:flutter/material.dart';
import 'package:proyecto/home.dart';
import 'package:proyecto/screens/add_carrera.dart';
import 'package:proyecto/screens/add_profe.dart';
import 'package:proyecto/screens/add_task.dart';
import 'package:proyecto/screens/carrera_screen.dart';
import 'package:proyecto/screens/profesor_screen.dart';
import 'package:proyecto/task_screen.dart';


Map<String,WidgetBuilder> getRoutes(){
  return{
    '/dash': (BuildContext context) => Home(),
    '/task' : (BuildContext context) => TaskScreen(),
    '/add' : (BuildContext context) => AddTask(),
    '/addProfe': (BuildContext context) => AddProfesor(),
    '/profesor': (BuildContext context) => ProfesorScreen(),
    '/carrera': (BuildContext context) => CarreraScreen(),
    '/addCarrera': (BuildContext context) => AddCarrera(),
  };
}
