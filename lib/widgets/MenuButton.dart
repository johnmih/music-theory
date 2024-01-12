import 'package:flutter/material.dart';
import 'package:music_theory/configuration/preferences.dart';

class MenuButton extends StatelessWidget {

  final String label;
  final String page;
  final IconData? icon;

  const MenuButton({
    
    required this.label,
    required this.page,
    required this.icon
  
  });
  
  @override
  Widget build(BuildContext context) {
    return Padding(  
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Preferences().darkMode ? Preferences().darkAccent:Preferences().lightAccent,
          minimumSize: const Size(300, 100),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          )
        ),
        icon: Icon(
          icon, size: 34,
          color: Preferences().darkMode? Preferences().darkText:Preferences().lightText,
        ),
        label: Text(
          label, 
          style: TextStyle(
            color: Preferences().darkMode? Preferences().darkText:Preferences().lightText,
            fontSize: 34, 
            fontWeight: FontWeight.bold
          )
        ),
        onPressed: () {Navigator.pushNamed(context, page);},
      ),
    );
  }
}