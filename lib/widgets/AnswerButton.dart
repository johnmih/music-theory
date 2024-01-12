import 'package:flutter/material.dart';
import 'dart:async';
import 'package:music_theory/configuration/preferences.dart';

class AnswerButton extends StatefulWidget {
  
  final bool isCorrect;
  final VoidCallback onPressed;
  final String buttonText;

  const AnswerButton({
    Key? key,
    required Text child,
    required this.isCorrect,
    required this.onPressed, 
    required this.buttonText,
  }) : super(key: key);

  @override
  _AnswerButtonState createState() => _AnswerButtonState();
}

class _AnswerButtonState extends State<AnswerButton> {
  
  Color buttonColor = Preferences().darkMode ? const Color(0xff039c9c):const Color(0xff87ceeb);


  void flicker() {
    setState(() {

      buttonColor = widget.isCorrect ? Colors.green : Colors.red;
    });

    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        buttonColor = Preferences().darkMode ? const Color(0xff039c9c):const Color(0xff87ceeb);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: () {
      
          widget.onPressed();
          flicker();
        },
        style: ElevatedButton.styleFrom(

          minimumSize: Size(100, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          backgroundColor: buttonColor,
        ),
        child: Text(
          widget.buttonText,
          style: TextStyle(
            color: Preferences().darkMode? const Color(0xffe0e0e0):const Color(0xff333333),
            fontSize: 40.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}