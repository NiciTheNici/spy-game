import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'game_settings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final _defaultLightColorScheme =
      ColorScheme.fromSwatch(primarySwatch: Colors.blue);

  static final _defaultDarkColorScheme = ColorScheme.fromSwatch(
      primarySwatch: Colors.blue, brightness: Brightness.dark);
  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(builder: (lightColorScheme, darkColorScheme) {
      return MaterialApp(
        title: 'Spy Game',
        theme: ThemeData(
          colorScheme: lightColorScheme ?? _defaultLightColorScheme,
          useMaterial3: true,
        ),
        darkTheme: ThemeData(
          colorScheme: darkColorScheme ?? _defaultDarkColorScheme,
          useMaterial3: true,
        ),
        themeMode: ThemeMode.system,
        home: const MyHomePage(title: 'Spy Game'),
      );
    });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GameSettings gameSettings = GameSettings();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        // TODO also fix back button that currently doesnt unfocus
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        behavior: HitTestBehavior.translucent,
        child: Align(
          child: Column(
            children: [
              Container(
                  alignment: Alignment.topCenter,
                  margin: const EdgeInsets.only(top: 200),
                  child:
                      Text(widget.title, style: const TextStyle(fontSize: 32))),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 50),
                child: Divider(
                  height: 100,
                  color: Theme.of(context).colorScheme.primary,
                  thickness: 5,
                ),
              ),
              gameSettings.settingsWidget(context),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // print(gameSettings.currentNumberOfPlayers);
          // print(gameSettings.currentNumberOfSpies);
          // print(gameSettings.currentTimeLimit);
        },
        child: const Icon(Icons.play_arrow_rounded),
      ),
    );
  }
}
