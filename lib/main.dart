import 'package:flutter/material.dart';
import 'package:music_theory/loading.dart';
import 'package:music_theory/menu.dart';
import 'package:music_theory/solfez.dart';
import 'package:music_theory/theory.dart';
import 'package:music_theory/sight_reading/trainer.dart';
import 'package:music_theory/configuration/settings.dart';
import 'package:music_theory/rythm.dart';

void main() => runApp(MaterialApp(

  initialRoute: '/',
  routes: {
    
    '/':(context) => Loading(),
    '/menu': (context) => Menu(),
    '/theory': (context) => Theory(),
    '/solfez': (context) => Solfez(),
    '/settings': (context) => Settings(),
    '/trainer': (context) => Trainer(),
    '/rythm': (context) => Rythm(),

  },
));
