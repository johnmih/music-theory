import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:music_theory/configuration/preferences.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:music_theory/menu.dart';

class Settings extends StatefulWidget {

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  
  bool treble = Preferences().treble;
  bool bass = Preferences().bass;
  bool alto = Preferences().alto;
  bool tenor = Preferences().tenor;

  bool abc = Preferences().abc;
  bool doremi = Preferences().doremi;

  bool audio = Preferences().audio;
  bool darkMode = Preferences().darkMode;


  bool relaxed = Preferences().relaxed;
  bool timed = Preferences().timed;
  double timedSecs = Preferences().timedSecs;
  double timedMins = Preferences().timedSecs/60;

  bool hardcore = Preferences().hardcore;
  double hcTime = Preferences().hcTime;

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(

      appBar: AppBar(

        centerTitle: true,
        title: Text(
          'Settings',
          style: TextStyle(
            fontSize: 40.0,
            color: darkMode ? Preferences().darkText:Preferences().lightText,
          ),
        ),
        leading: IconButton(
          
          icon: const Icon(Icons.arrow_back),
          color: darkMode ? Preferences().darkAccent:Preferences().lightAccent,
          onPressed: (){Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Menu()), (route) => false);}
        ),
        backgroundColor: darkMode ? Preferences().darkBG:Preferences().lightBG,
      ),
      body: Column(
        children: [
          Text(
            'Clefs',
            style: TextStyle(
              color: darkMode? Preferences().darkText:Preferences().lightText,
              fontSize: 24.0,
            ),
          ),
          CheckboxListTile(
            
            title: Text(
              'Treble Cleff',
              style: TextStyle(
                color: darkMode? Preferences().darkText:Preferences().lightText,
              ),
            ),
            secondary: Image.asset('assets/icons/treble.png'),
            subtitle: abc? 
              Text(
                'Covers range from A3 to C6',
                style: TextStyle(
                  color: darkMode? Preferences().darkText:Preferences().lightText,
                ),
              ):
              Text(
                'Covers range from La3 to Do6',
                style: TextStyle(
                  color: darkMode? Preferences().darkText:Preferences().lightText,
                ),
              ),
            value: treble,
            activeColor: darkMode ? Preferences().darkAccent:Preferences().lightAccent,
            onChanged: (bool? newValue) {saveTreble(newValue);}
          ),
          CheckboxListTile(
            
            title: Text(
              'Bass Cleff',
              style: TextStyle(
                color: darkMode? Preferences().darkText:Preferences().lightText,
              ),
            ),
            secondary: Image.asset('assets/icons/bass.png'),
            subtitle: abc?
              Text(
                'Covers range from C2 to E4',
                style: TextStyle(
                  color: darkMode? Preferences().darkText:Preferences().lightText,
                ),
              ):
              Text(
                'Covers range from Do2 to Mi4',
                style: TextStyle(
                  color: darkMode? Preferences().darkText:Preferences().lightText,
                ),
              ),
            value: bass,
            activeColor: darkMode ? Preferences().darkAccent:Preferences().lightAccent,
            onChanged: (bool? newValue) {saveBass(newValue);}
          ),
          CheckboxListTile(
            
            title: Text(
              'Alto Cleff',
              style: TextStyle(
                color: darkMode? Preferences().darkText:Preferences().lightText,
              ),
            ),
            secondary: Image.asset('assets/icons/alto-tenor.png'),
            subtitle: abc?
              Text(
                'Covers range from B2 to D5',
                style: TextStyle(
                  color: darkMode? Preferences().darkText:Preferences().lightText,
                ),
              ):
              Text(
                'Covers range from Si2 to Re5',
                style: TextStyle(
                  color: darkMode? Preferences().darkText:Preferences().lightText,
                ),
              ),
            value: alto,
            activeColor: darkMode ? Preferences().darkAccent:Preferences().lightAccent,
            onChanged: (bool? newValue) {saveAlto(newValue);}
          ),
          CheckboxListTile(
            
            title: Text(
              'Tenor Cleff',
              style: TextStyle(
                color: darkMode? Preferences().darkText:Preferences().lightText,
              ),
            ),
            secondary: Image.asset('assets/icons/alto-tenor.png'),
            subtitle: abc?
              Text(
                'Covers range from G2 to B4',
                style: TextStyle(
                color: darkMode? Preferences().darkText:Preferences().lightText,
                ),
              ):
              Text(
                'Covers range from Sol2 to Si4',
                style: TextStyle(
                color: darkMode? Preferences().darkText:Preferences().lightText,
                ),
              ),
            value: tenor,
            activeColor: darkMode ? Preferences().darkAccent:Preferences().lightAccent,
            onChanged: (bool? newValue) {saveTenor(newValue);}
          ),
          Divider(
            thickness: 2.0,
            color: darkMode ? Preferences().darkDetail : Preferences().lightDetail,
          ),
          Text(
            'Notation System',
            style: TextStyle(
              color: darkMode? Preferences().darkText:Preferences().lightText,
              fontSize: 24.0,
            ),
          ),
          CheckboxListTile(
            
            title: Text(
              'C, D, E, F, G, A, B',
              style: TextStyle(
                color: darkMode? Preferences().darkText:Preferences().lightText,
              ),
            ),
            value: abc,
            activeColor: darkMode ? Preferences().darkAccent:Preferences().lightAccent,
            onChanged: (bool? newValue) {saveABC(newValue);}
          ),
          CheckboxListTile(
            
            title: Text(
              'Do, Re, Mi, Fa, Sol, La, Si',
              style: TextStyle(
                color: darkMode? Preferences().darkText:Preferences().lightText,
              ),
            ),
            value: doremi,
            activeColor: darkMode ? Preferences().darkAccent:Preferences().lightAccent, 
            onChanged: (bool? newValue) {saveDoReMi(newValue);}
          ),
          Divider(
            thickness: 2.0,
            color: darkMode ? Preferences().darkDetail : Preferences().lightDetail,
          ),
          Text(
            'Mode',
            style: TextStyle(
              color: darkMode? Preferences().darkText:Preferences().lightText,
              fontSize: 24.0,
            ),
          ),
          CheckboxListTile(
            
            title: Text(
              'Relaxed Mode',
              style: TextStyle(
                color: darkMode? Preferences().darkText:Preferences().lightText,
              ),
            ),
            subtitle: Text(
              'No time pressure at all',
              style: TextStyle(
                color: darkMode? Preferences().darkText:Preferences().lightText,
              ),
            ),
            secondary: Icon(
              FontAwesomeIcons.mugHot,
              color: darkMode? Preferences().darkText:Preferences().lightText,
            ),     
            value: relaxed,
            activeColor: darkMode ? Preferences().darkAccent:Preferences().lightAccent,
            onChanged: (bool? newValue) {saveRelaxed(newValue);}
          ),
          CheckboxListTile(
            
            title: Text(
              'Timed Mode',
              style: TextStyle(
                color: darkMode? Preferences().darkText:Preferences().lightText,
              ),
            ),
            subtitle: timedSecs<60? 
              Text(
                'Answer as many tests as you can in $timedSecs seconds',
                style: TextStyle(
                  color: darkMode? Preferences().darkText:Preferences().lightText,
                ),
              ):
              Text(
                'Answer as many tests as you can in $timedMins minutes',
                style: TextStyle(
                  color: darkMode? Preferences().darkText:Preferences().lightText,
                ),
              ),
            secondary: Icon(
              FontAwesomeIcons.clock,
              color: darkMode? Preferences().darkText:Preferences().lightText,
            ),
            value: timed,
            activeColor: darkMode ? Preferences().darkAccent:Preferences().lightAccent,
            onChanged: (bool? newValue) {saveTimed(newValue);}
          ),
          Slider(
            value: timedSecs,
            activeColor: timed ? 
              darkMode ? Preferences().darkAccent:Preferences().lightAccent:
              darkMode? Preferences().darkText:Preferences().lightText,
            onChanged: (double newSel) {saveTimedSecs(newSel);},
            min: 30,
            max: 300,
            divisions: 9,
            label: timedSecs.round().toString(),
          ),
          CheckboxListTile(
            
            title: Text(
              'Hardcore Mode',
              style: TextStyle(
                color: darkMode? Preferences().darkText:Preferences().lightText,
              ),
            ),
            subtitle: Text(
              'No room for error! You have $hcTime seconds to identify the note correctly',
              style: TextStyle(
                color: darkMode? Preferences().darkText:Preferences().lightText,
              ),
            ),
            secondary: Icon(
              FontAwesomeIcons.skullCrossbones,
              color: darkMode? Preferences().darkText:Preferences().lightText,
            ),
            value: hardcore,
            activeColor: darkMode ? Preferences().darkAccent:Preferences().lightAccent,
            onChanged: (bool? newValue) {saveHardcore(newValue);}
          ),
          Slider(
            value: hcTime, 
            activeColor: hardcore ? 
              darkMode ? Preferences().darkAccent:Preferences().lightAccent:
              darkMode? Preferences().darkText:Preferences().lightText,
            onChanged: (double newSel) {saveHCTime(newSel);},
            min: 1,
            max: 10,
            divisions: 9,
            label: hcTime.round().toString(),
          ),
          Divider(
            thickness: 2.0,
            color: darkMode ? Preferences().darkDetail : Preferences().lightDetail,
          ),
          Text(
            'General',
            style: TextStyle(
              color: darkMode? Preferences().darkText:Preferences().lightText,
              fontSize: 24.0,
            ),
          ),
          CheckboxListTile(
            
            title: Text(
              'Sound',
              style: TextStyle(
                color: darkMode? Preferences().darkText:Preferences().lightText,
              ),
            ),
            subtitle: Text(
              'Disables sound playback during the excersise',
              style: TextStyle(
                color: darkMode? Preferences().darkText:Preferences().lightText,
              ),
            ),
            secondary: audio ? 
              Icon(
                Icons.volume_up,
                color: darkMode? Preferences().darkText:Preferences().lightText,
              ):
              Icon(
                Icons.volume_off,
                color: darkMode? Preferences().darkText:Preferences().lightText,
              ),
            value: audio,
            activeColor: darkMode ? Preferences().darkAccent:Preferences().lightAccent,
            onChanged: (bool? newValue) {saveAudio(newValue);}
          ),
          CheckboxListTile(
            
            title: Text(
              'Dark Mode',
              style: TextStyle(
                color: darkMode? Preferences().darkText:Preferences().lightText,
              ),
            ),
            subtitle: Text(
              'Swiches to dark mode',
              style: TextStyle(
                color: darkMode? Preferences().darkText:Preferences().lightText,
              ),
            ),
            secondary: darkMode ? 
            Icon(
              Icons.dark_mode,
              color: darkMode? Preferences().darkText:Preferences().lightText,
            ):
            Icon(
              Icons.light_mode,
              color: darkMode? Preferences().darkText:Preferences().lightText,                       
            ),
            value: darkMode,
            activeColor: darkMode ? Preferences().darkAccent:Preferences().lightAccent,
            onChanged: (bool? newValue) {saveDarkMode(newValue);}
          ),
          Divider(
            thickness: 2.0,
            color: darkMode ? Preferences().darkDetail : Preferences().lightDetail,
          ),
        ],
      ),
      backgroundColor: darkMode ? Preferences().darkBG:Preferences().lightBG,
    );
  }

  void saveTreble(bool? newValue) async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      if(!treble || bass || alto || tenor){
        treble = newValue!;
        Preferences().treble = treble;
        prefs.setBool('treble', treble);
      }
    });
  }

  void saveBass(bool? newValue) async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      if(treble || !bass || alto || tenor){
        bass = newValue!;
        Preferences().bass = bass;
        prefs.setBool('bass', bass);
      }
    });
  }

  void saveAlto(bool? newValue) async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      if(treble || bass || !alto || tenor){
        alto = newValue!;
        Preferences().alto = alto;
        prefs.setBool('alto', alto);
      }
    });
  }

  void saveTenor(bool? newValue) async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      if(treble || bass || alto || !tenor){
        tenor = newValue!;
        Preferences().tenor = tenor;
        prefs.setBool('tenor', tenor);
      }
    });
  }

  void saveABC(bool? newValue) async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      abc = newValue!;
      doremi = abc ? false:true;
      Preferences().abc = abc;
      prefs.setBool('abc', abc);
      Preferences().doremi = doremi;
      prefs.setBool('doremi', doremi);
    });
  }

  void saveDoReMi(bool? newValue) async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      doremi = newValue!;
      abc = doremi ? false:true;
      Preferences().doremi = doremi;
      prefs.setBool('doremi', doremi);
      Preferences().abc = abc;
      prefs.setBool('abc', abc);
    });
  }

  void saveRelaxed(bool? newValue) async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      relaxed = newValue!;
      if(relaxed){
        timed = false;
        hardcore = false;
      }
      if(!(relaxed || timed || hardcore)){
        relaxed = true;
      }
      Preferences().relaxed = relaxed;
      prefs.setBool('relaxed', relaxed);
      Preferences().timed = timed;
      prefs.setBool('timed', timed);
      Preferences().hardcore = hardcore;
      prefs.setBool('hardcore', hardcore);
    });
  }
  
  void saveTimed(bool? newValue) async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      timed = newValue!;
      if(timed){
        relaxed = false;
        hardcore = false;
      }
      if(!(relaxed || timed || hardcore)){
        relaxed = true;
      }
      Preferences().relaxed = relaxed;
      prefs.setBool('relaxed', relaxed);
      Preferences().timed = timed;
      prefs.setBool('timed', timed);
      Preferences().hardcore = hardcore;
      prefs.setBool('hardcore', hardcore);
    });
  }

  void saveTimedSecs(double? newSel) async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if(timed){
      setState(()  {
        timedSecs = newSel!;
        timedMins = newSel/60;
        Preferences().timedSecs = timedSecs;
        prefs.setDouble('timedSecs', timedSecs);
      });
    }
  }

  void saveHardcore(bool? newValue) async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      hardcore = newValue!;
      if(hardcore){
        relaxed = false;
        timed = false;
      }
      if(!(relaxed || timed || hardcore)){
        relaxed = true;
      }
      Preferences().relaxed = relaxed;
      prefs.setBool('relaxed', relaxed);
      Preferences().timed = timed;
      prefs.setBool('timed', timed);
      Preferences().hardcore = hardcore;
      prefs.setBool('hardcore', hardcore);
    });
  }

  void saveHCTime(double? newSel) async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if(hardcore){
      setState(()  {
        hcTime = newSel!;
        Preferences().hcTime = hcTime;
        prefs.setDouble('hcTime', hcTime);
      });
    }
  }

  void saveAudio(bool? newValue) async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      audio = newValue!;
      Preferences().audio = audio;
      prefs.setBool('audio', audio);
    });
  }

  void saveDarkMode(bool? newValue) async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      darkMode = newValue!;
      Preferences().darkMode = darkMode;
      prefs.setBool('darkMode', darkMode);
    });
  }
}