// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:music_theory/configuration/preferences.dart';
import 'dart:math';

class Note{

  late String value;
  List<String> range = [];

  Note(){

    range = getRange();
    value = range[Random().nextInt(range.length)];
  }

  double offset(){
    
    double offset = 0;
    for(int i=0; i<range.length; i++)
      if(range[i].substring(3)==value.substring(3)){
        
        if(range[i]==value)
          return offset;
        offset += 16.5;        
      }
    
    return offset;
  }

  String clef(){

    return value.substring(2);
  }

  String name(){
    return value.substring(0,2);
  }

  String lines(){
    
    if(offset()>2*16.5 && offset()<14*16.5)
      return '0';
    else if(offset()==16*16.5)
      return '2';
    else if(offset()<16*16.5 && offset()>13*16.5)
      return '1';
    else if(offset()==0)
      return '-2';
    else
      return '-1';
  }

  List<String> getRange(){

    if(Preferences().treble)
      range.addAll(trebleRange);
    if(Preferences().bass)
      range.addAll(bassRange);
    if(Preferences().alto)
      range.addAll(altoRange);
    if(Preferences().tenor)
      range.addAll(tenorRange);

    return range;
  }

  static List<String> trebleRange = ['A3treble', 'B3treble', 
  'C4treble', 'D4treble', 'E4treble', 'F4treble', 'G4treble', 'A4treble', 'B4treble', 
  'C5treble', 'D5treble', 'E5treble', 'F5treble', 'G5treble', 'A5treble', 'B5treble', 
  'C6treble'];
  static List<String> bassRange = [
  'C2bass', 'D2bass', 'E2bass', 'F2bass', 'G2bass', 'A2bass', 'B2bass', 
  'C3bass', 'D3bass', 'E3bass', 'F3bass', 'G3bass', 'A3bass', 'B3bass', 
  'C4bass', 'D4bass', 'E4bass'];
  static List<String> altoRange = ['B2alto', 
  'C3alto', 'D3alto', 'E3alto', 'F3alto', 'G3alto', 'A3alto', 'B3alto', 
  'C4alto', 'D4alto', 'E4alto', 'F4alto', 'G4alto', 'A4alto', 'B4alto', 
  'C5alto', 'D5alto'];
  static List<String> tenorRange = ['G2tenor', 'A2tenor', 'B2tenor', 
  'C3tenor', 'D3tenor', 'E3tenor', 'F3tenor', 'G3tenor', 'A3tenor', 'B3tenor', 
  'C4tenor', 'D4tenor', 'E4tenor', 'F4tenor', 'G4tenor', 'A4tenor', 'B4tenor'];
}