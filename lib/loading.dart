import 'package:flutter/material.dart';
import 'package:music_theory/configuration/preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
    
  void loadData() async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      Preferences().treble = prefs.getBool('treble') ?? true;
      Preferences().bass = prefs.getBool('bass') ?? false;
      Preferences().alto = prefs.getBool('alto') ?? false;
      Preferences().tenor = prefs.getBool('tenor') ?? false;

      Preferences().abc = prefs.getBool('abc') ?? true;
      Preferences().doremi = prefs.getBool('doremi') ?? false;

      Preferences().relaxed = prefs.getBool('relaxed') ?? true;
      Preferences().timed = prefs.getBool('timed') ?? false;
      Preferences().timedSecs = prefs.getDouble('timedSecs') ?? 60;
      Preferences().hardcore = prefs.getBool('hardcore') ?? false;
      Preferences().hcTime = prefs.getDouble('hcTime') ?? 5;

      Preferences().audio = prefs.getBool('audio') ?? true;
      Preferences().darkMode = prefs.getBool('darkMode') ?? false;

      Preferences().hsRelaxed = prefs.getInt('hsRelaxed') ?? 0;
      Preferences().hsTimed = prefs.getInt('hsTimed') ?? 0;
      Preferences().hsHardcore = prefs.getInt('hsHardcore') ?? 0;
      }
    );
  }

  void play(String path) {

    AudioPlayer note = AudioPlayer();
    note.play(AssetSource(path));
  }

  @override
  void initState(){

    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Future.delayed(const Duration(seconds: 3), () {
      if(Preferences().audio)
        play('/sound/The Lick.mp3');
      Navigator.pushReplacementNamed(context, '/menu');
    });

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Loading...',
          style: TextStyle(
            fontSize: 40.0,
            color: Preferences().darkMode ? Preferences().darkText : Preferences().lightText,
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Preferences().darkMode ? Preferences().darkBG : Preferences().lightBG,
      ),
      body: Center(
        child: CircularProgressIndicator(
          strokeWidth: 10.0,
          color: Preferences().darkMode ? Preferences().darkAccent : Preferences().lightAccent,
          backgroundColor: Preferences().darkMode ? Preferences().darkText : Preferences().lightText,
        ), 
      ),
      backgroundColor: Preferences().darkMode ? Preferences().darkBG : Preferences().lightBG,
    );
  }
}