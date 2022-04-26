import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'agify.dart';
import 'cat.dart';
import 'joke.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();

  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Good mood',
      theme: ThemeData(          // Add the 5 lines from here...
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
      ),
      darkTheme: ThemeData.dark(),
      themeMode: _themeMode,
      home: const JokesWidget(),
    );
  }

  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

  bool isDarkTheme() {
    return _themeMode == ThemeMode.dark;
  }
}

class JokesWidget extends StatefulWidget {
  const JokesWidget({Key? key}) : super(key: key);

  @override
  State<JokesWidget> createState() => _JokesState();
}

class _JokesState extends State<JokesWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static const List<Widget> _widgetOptions = <Widget>[
    CatPageWidget(),
    AgifyPage(),
    JokePageWidget(),
    SettingsPageWidget(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Good mood'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.cat),
            label: 'Cats',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.babyCarriage),
            label: 'Age',
            backgroundColor: Colors.amber,
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.faceSmile),
            label: 'Joke',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
            backgroundColor: Colors.green,
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class SettingsPageWidget extends StatefulWidget {
  const SettingsPageWidget({Key? key}) : super(key: key);

  @override
  State<SettingsPageWidget> createState() => _SettingsPageWidgetState();
}

class _SettingsPageWidgetState extends State<SettingsPageWidget> {
  bool useDarkTheme = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(left: 16.0, top: 10.0, right: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                    "Use system theme",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal)
                ),
                Switch(
                  value: MyApp.of(context)?._themeMode == ThemeMode.system,
                  onChanged: (value) {
                    setState(() {
                      if (value) {
                        MyApp.of(context)?.changeTheme(ThemeMode.system);
                      } else {
                        if (useDarkTheme) {
                          MyApp.of(context)?.changeTheme(ThemeMode.dark);
                        } else {
                          MyApp.of(context)?.changeTheme(ThemeMode.light);
                        }
                      }
                    });
                  },
                ),
              ],
            ),
          ),
          Visibility(
              visible: MyApp.of(context)?._themeMode != ThemeMode.system,
              child: Container(
                margin:
                    const EdgeInsets.only(left: 16.0, right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                        "Use dark theme",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal)
                    ),
                    Switch(
                      value: useDarkTheme,
                      onChanged: (value) {
                        setState(() {
                          useDarkTheme = value;
                          if (useDarkTheme) {
                            MyApp.of(context)?.changeTheme(ThemeMode.dark);
                          } else {
                            MyApp.of(context)?.changeTheme(ThemeMode.light);
                          }
                        });
                      },
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}