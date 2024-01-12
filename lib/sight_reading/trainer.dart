// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:music_theory/menu.dart';
import 'package:music_theory/sight_reading/score.dart';
import 'package:music_theory/configuration/preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:music_theory/sight_reading/note.dart';
import 'dart:async';
import 'package:music_theory/widgets/AnswerButton.dart';
import 'package:audioplayers/audioplayers.dart';

class Trainer extends StatefulWidget {
  
  @override
  State<Trainer> createState() => _Trainer();
}

class _Trainer extends State<Trainer> {

  late List<String> range;
  late Note currNote;

  int ansTotal = 0;
  int ansRight = 0;
  int ansWrong = 0;
  int accuracy = 0;

  _Trainer(){
    
    range = Note().getRange();
    currNote = Note();
    if(Preferences().audio)
      play('/sound/${currNote.name()}.mp3');
    if(Preferences().timed) {
      clock = Preferences().timedSecs.toString();
      startTimer(Preferences().timedSecs);              
    }
    if(Preferences().hardcore) {
      clock = Preferences().hcTime.toString();
      startTimer(Preferences().hcTime);              
    }  
  }
  
  void Ans(bool answer){

    ansTotal++;
    if(answer) {
      if(Preferences().hardcore) {
        resetTimer();
      }   
      setState(() {
        ansRight++;
        newNote();
      });
    } 
    else {  
      if(Preferences().hardcore){

        countdown.cancel();
        saveHighScore();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Score(
          ansRight: ansRight, 
          ansWrong: ansWrong,
          ansTotal: ansTotal, 
        )));
      }
      setState(() {
        ansWrong++;
        if(Preferences().audio)
          play('/sound/${currNote.name()}.mp3');
      });
    }
    accuracy = ((ansRight/ansTotal)*100).round();
  }

  void newNote(){
    setState(() {
      
      Note preNote = currNote;
      
      do{currNote = Note();}
      while(preNote.value==currNote.value);

      if(Preferences().audio)
        play('/sound/${currNote.name()}.mp3');
    });  
  }

  void play(String path) {

    AudioPlayer note = AudioPlayer();
    note.play(AssetSource(path));
  }

  late Timer countdown;
  late String clock;
  
  void startTimer(double currSeconds) {

    countdown = Timer.periodic(const Duration(milliseconds: 10), (timer) {

      if(currSeconds > 0) {
        currSeconds -= 0.01;
        setState(() {
          if(currSeconds>10)
            clock = (currSeconds.truncate()+1).toString();
          else
            clock = currSeconds.toStringAsFixed(1);
        });
      } 
      else {
        timer.cancel();
        saveHighScore();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Score(
          ansRight: ansRight, 
          ansWrong: ansWrong,
          ansTotal: ansTotal, 
        ))); 
      }
    });
  }

  void resetTimer(){

    countdown.cancel();
    if(Preferences().timed)
      startTimer(Preferences().timedSecs);
    else if(Preferences().hardcore)
      startTimer(Preferences().hcTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        
        centerTitle: true,
        title: Text(
          'Sight Reading',
          style: TextStyle(
            fontSize: 40.0,
            color: Preferences().darkMode? Preferences().darkText:Preferences().lightText,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Preferences().darkMode ? Preferences().darkAccent:Preferences().lightAccent,
          onPressed: () {
            if(Preferences().timed || Preferences().hardcore)
              countdown.cancel();
            
            showDialog(
                context: context, 
                builder: (context) => AlertDialog(
                  actions: [
                    TextButton(
                      onPressed: () {
                        saveHighScore();
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Menu()), (route) => false);
                      }, 
                      child: Text(
                        'Yes',
                        style: TextStyle(
                          color: Preferences().darkMode ? Preferences().darkAccent : Preferences().lightAccent,
                        ),
                      )
                    ),
                    TextButton(
                      onPressed: () {
                        if(Preferences().timed || Preferences().hardcore)
                          startTimer(double.parse(clock));
            
                        Navigator.of(context).pop();
                      }, 
                      child: Text(
                        'No',
                        style: TextStyle(
                          color: Preferences().darkMode ? Preferences().darkAccent : Preferences().lightAccent,
                        ),
                      )
                    )
                  ],
                  title: const Text('Return to main menu?'),
                  contentPadding: const EdgeInsets.all(20.0),
                  content: const Text('The current sesssion will be terminated'),
                )
              );
          },
        ),
        backgroundColor: Preferences().darkMode ? Preferences().darkBG:Preferences().lightBG,
      ),
      body: Column(
        children: [         
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(               
                padding: const EdgeInsets.all(16.0),
                child: Text(

                  'Total Efforts: $ansTotal',
                  style: TextStyle(
                    color: Preferences().darkMode? Preferences().darkText:Preferences().lightText,
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(               
                padding: const EdgeInsets.all(16.0),
                child: Text(

                  'Acccuracy: $accuracy%',
                  style: TextStyle(
                    color: Preferences().darkMode? Preferences().darkText:Preferences().lightText,
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
          Container(
          
            padding: const EdgeInsets.all(16.0),
            child: Text(

              Preferences().relaxed ? 'No timer' : 'Time Remaining: $clock',
              style: TextStyle(
                color: Preferences().darkMode? Preferences().darkText:Preferences().lightText,
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(               
                padding: const EdgeInsets.all(16.0),
                child: Text(

                  '$ansRight/$ansTotal',
                  style: TextStyle(
                    color: Preferences().darkMode? Preferences().darkText:Preferences().lightText,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          Container(
            
            alignment: Alignment.topCenter,
            child: Stack(
              children:[
                Image(
                  image: AssetImage('assets/images/staff/${currNote.lines()}.jpg'),
                  height: 500.0,
                  width: 1000.0,          
                ),
                Image(
                  image: AssetImage('assets/images/clefs/${currNote.clef()}.png'),
                  height: 500.0,
                  width: 1000.0,          
                ),
                Positioned(
                  bottom: currNote.offset(),
                  child: const Image(
                    image: AssetImage('assets/images/notehead.png'),
                    height: 500.0,
                    width: 1000.0,          
                  ),
                ),
              ]
            )
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AnswerButton(
                
                buttonText: (Preferences().abc ? 'C':'Do'),
                isCorrect: currNote.name().substring(0,1)=='C' ? true : false,
                onPressed: () {Ans(currNote.name().substring(0,1)=='C');},
                child: const Text('C'),
              ),
              AnswerButton(
                
                buttonText: Preferences().abc? 'D':'Re',
                isCorrect: currNote.name().substring(0,1)=='D' ? true : false,
                onPressed: () {Ans(currNote.name().substring(0,1)=='D');},
                child: const Text('D')
              ),
              AnswerButton(
                
                buttonText: (Preferences().abc ? 'E':'Mi'),
                isCorrect: currNote.name().substring(0,1)=='E' ? true : false,
                onPressed: () {Ans(currNote.name().substring(0,1)=='E');},
                child: const Text('E')
              ),
              AnswerButton(
                
                buttonText: (Preferences().abc ? 'F':'Fa'),
                isCorrect: currNote.name().substring(0,1)=='F' ? true : false,
                onPressed: () {Ans(currNote.name().substring(0,1)=='F');},
                child: const Text('F')
              ),   
              AnswerButton(

                buttonText: Preferences().abc? 'G':'Sol',
                isCorrect: currNote.name().substring(0,1)=='G' ? true : false,
                onPressed: () {Ans(currNote.name().substring(0,1)=='G');},
                child: const Text('G')
              ),
              AnswerButton(     

                buttonText: Preferences().abc? 'A':'La',
                isCorrect: currNote.name().substring(0,1)=='A' ? true : false,
                onPressed: () {Ans(currNote.name().substring(0,1)=='A');}, 
                child: const Text('A')
              ),
              AnswerButton(   

                buttonText: (Preferences().abc ? 'B':'Si'),
                isCorrect: currNote.name().substring(0,1)=='B' ? true : false,
                onPressed: () {Ans(currNote.name().substring(0,1)=='B');},
                child: const Text('B')
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              icon: Icon(
                Icons.check,
                color: Preferences().darkMode? Preferences().darkText : Preferences().lightText,
              ),
              label: Text(
                'End',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: Preferences().darkMode? Preferences().darkText : Preferences().lightText,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Preferences().darkMode ? Preferences().darkAccent:Preferences().lightAccent,
                minimumSize: const Size(100, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                )
              ),
              onPressed: () {
                if(Preferences().timed || Preferences().hardcore)
                  countdown.cancel();
                saveHighScore();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Score(
                  ansRight: ansRight, 
                  ansWrong: ansWrong,
                  ansTotal: ansTotal, 
                )));}, 
            ),
          ),
        ],    
      ),
      backgroundColor: Preferences().darkMode ? Preferences().darkBG:Preferences().lightBG,
    );
  }

  void saveHighScore() async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      
      if(Preferences().relaxed) {
        if(Preferences().hsRelaxed<ansRight){

          Preferences().hsRelaxed = ansRight;
          prefs.setInt('hsRelaxed', ansRight);
       }
      }

      if(Preferences().timed) {
        if(Preferences().hsTimed<ansRight){

          Preferences().hsTimed = ansRight;
          prefs.setInt('hsTimed', ansRight);
       }
      }

      if(Preferences().hardcore) {
        if(Preferences().hsHardcore<ansRight){

          Preferences().hsHardcore = ansRight;
          prefs.setInt('hsHardcore', ansRight);
       }
      }
    });
  }
}