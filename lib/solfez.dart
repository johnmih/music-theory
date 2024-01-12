import 'package:flutter/material.dart';
import 'package:music_theory/configuration/preferences.dart';

class Solfez extends StatefulWidget {

  @override
  State<Solfez> createState() => _SolfezState();
}

class _SolfezState extends State<Solfez> {
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      
      appBar: AppBar(
        
        centerTitle: true,
        title: Text(
          'Solfez',
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