import 'package:flutter/material.dart';

class Preferences{

  static final Preferences instance = Preferences.internal();

  Preferences.internal();

  factory Preferences(){
    return instance;
  }

  late bool treble = true;
  late bool bass = false;
  late bool alto = false;
  late bool tenor = false;

  late bool abc = true;
  late bool doremi = false;

  late bool relaxed = true;
  late bool timed = false;
  late double timedSecs = 60;
  late bool hardcore = false;
  late double hcTime = 5;

  late bool audio = true;
  late bool darkMode = false;

  late int hsRelaxed = 0;
  late int hsTimed = 0;
  late int hsHardcore = 0;

  //light theme
  Color lightBG = const Color(0xfff5f5f5);
  Color lightText = const Color(0xff333333);
  Color lightAccent = const Color(0xff87ceeb); 
  Color lightDetail = const Color(0xffcccccc);
  //dark theme
  Color darkBG = const Color(0xff121212);
  Color darkText = const Color(0xffe0e0e0);
  Color darkAccent = const Color(0xff039c9c);
  Color darkDetail = const Color(0xff0e4775);
}