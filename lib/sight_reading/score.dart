import 'package:flutter/material.dart';
import 'package:music_theory/configuration/preferences.dart';
import 'package:music_theory/widgets/MenuButton.dart';

class Score extends StatelessWidget {

  final int ansRight;
  final int ansWrong;
  final int ansTotal;

  const Score({
    
    required this.ansRight,
    required this.ansWrong,
    required this.ansTotal,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Score',
          style: TextStyle(
            fontSize: 40.0,
            color: Preferences().darkMode? Preferences().darkText:Preferences().lightText,
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Preferences().darkMode ? Preferences().darkBG:Preferences().lightBG,
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                ansRight.toString(),
                style: TextStyle(
                  color: Preferences().darkMode? Preferences().darkText:Preferences().lightText,
                  fontSize: 100.0,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Precision: $ansRight/$ansTotal',
                style: TextStyle(
                  color: Preferences().darkMode? Preferences().darkText:Preferences().lightText,
                ),
              ),
            ),
            Text(
              Preferences().relaxed ? 
              'High Score: ${Preferences().hsRelaxed}':
              Preferences().timed ?
              'High Score: ${Preferences().hsTimed}':
              'High Score: ${Preferences().hsHardcore}',
              style: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
                color: Preferences().darkMode ? Preferences().darkText :Preferences().lightText,
              ),
            ),
            const MenuButton(
              label: 'Try Again',
              page: '/trainer',
              icon: Icons.replay,
            ),
            const MenuButton(
              label: 'Main Menu',
              page: '/menu',
              icon: Icons.home,
            ),
            Text(
              Preferences().relaxed ? 'Relaxed Mode' : Preferences().timed ? 'Timed Mode' : 'Hardcore Mode',
              style: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
                color: Preferences().darkMode ? Preferences().darkDetail :Preferences().lightDetail,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Preferences().darkMode ? Preferences().darkBG:Preferences().lightBG,
    );
  }
}