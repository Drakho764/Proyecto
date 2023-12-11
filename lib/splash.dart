import 'dart:async';

import 'package:flutter/material.dart';
import 'package:proyecto/home.dart';
import 'package:proyecto/login_screen.dart';
import 'package:proyecto/routes.dart';
import 'package:proyecto/services/local_storage.dart';

class SplashView extends StatefulWidget {
  @override
  SplashViewState createState() => SplashViewState();
  
}

class SplashViewState extends State<SplashView> {
  final LocalStorage prefis =LocalStorage();
  @override
  void initState(){
     prefis.readCache('user').then((value) {
      if (value != null){
        return 
        Timer(Duration(seconds: 2), ()=>
           Navigator.push(context, MaterialPageRoute(builder: ((context)=> const Home())))
        );
      }else{
         return 
        Timer(Duration(seconds: 2), ()=>
           Navigator.push(context, MaterialPageRoute(builder: ((context)=> const LoginScreen())))
        );
      }
    });
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}