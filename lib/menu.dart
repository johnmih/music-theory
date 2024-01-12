import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:music_theory/configuration/preferences.dart';
import 'package:music_theory/widgets/MenuButton.dart';

class Menu extends StatefulWidget {

  @override
  State<Menu> createState() => _Menu();
}

class _Menu extends State<Menu> {
  
  @override
  Widget build(BuildContext context){

    return Scaffold(
      
      appBar: AppBar(
        title: Text(
          'Main Menu',
          style: TextStyle(
            fontSize: 40.0,
            color: Preferences().darkMode? Preferences().darkText:Preferences().lightText,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Preferences().darkMode ? Preferences().darkBG:Preferences().lightBG,
      ),
      body: const Center(
        child: Column(     
          
          mainAxisAlignment: MainAxisAlignment.start,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            SizedBox(height: 100.0),       
            MenuButton(label: 'Solfez', page: '/solfez', icon: Icons.music_note_sharp),
            MenuButton(label: 'Sight Reading', page: '/trainer', icon: FontAwesomeIcons.music),
            MenuButton(label: 'Rythm', page: '/rythm', icon: FontAwesomeIcons.drum),
            MenuButton(label: 'Theory', page: '/theory', icon: Icons.book),
            MenuButton(label: 'Settings', page: '/settings', icon: Icons.settings),
          ],
        ),
      ),
      backgroundColor: Preferences().darkMode ? Preferences().darkBG:Preferences().lightBG,
    );
  }
}