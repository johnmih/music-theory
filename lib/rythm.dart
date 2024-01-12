import 'package:flutter/material.dart';
import 'package:music_theory/configuration/preferences.dart';

class Rythm extends StatefulWidget {

  @override
  State<Rythm> createState() => _RythmState();
}

class _RythmState extends State<Rythm> {
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      
      appBar: AppBar(
        
        centerTitle: true,
        title: Text(
          'Rythm Trainer',
          style: TextStyle(
            fontSize: 40.0,
            color: Preferences().darkMode? Preferences().darkText:Preferences().lightText,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Preferences().darkMode ? Preferences().darkAccent:Preferences().lightAccent,
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Preferences().darkMode ? Preferences().darkBG:Preferences().lightBG,
      ),
      backgroundColor: Preferences().darkMode ? Preferences().darkBG:Preferences().lightBG,
    );
  }
}