import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static late SharedPreferences prefs;

  static Future<void> configurePrefs() async{
    
    prefs= await SharedPreferences.getInstance();
  }
  Future readCache(String user) async {
    prefs= await SharedPreferences.getInstance();
    var cache=prefs.getString('user');
    return cache;
  }
}
//Practica 3