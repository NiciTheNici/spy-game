import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
        title: 'Flutter Demo',
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Align(
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          Container(
              alignment: Alignment.topCenter,
              margin: const EdgeInsets.only(top: 200),
              child: Text(widget.title, style: const TextStyle(fontSize: 32))),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Divider(
              height: 100,
              color: Theme.of(context).colorScheme.primary,
              thickness: 5,
            ),
          ),
          _adjustableSettings(),
        ],
      ),
    ));
  }

  Widget _adjustableSettings() {
    const iconMargin = EdgeInsets.symmetric(vertical: 5, horizontal: 15);

    return Row(
      children: [
        Column(
          children: [
            Container(
              margin: iconMargin,
              alignment: Alignment.centerLeft,
              child: const FaIcon(
                FontAwesomeIcons.users,
                size: 18,
              ),
            ),
            Container(
                margin: iconMargin,
                alignment: Alignment.centerLeft,
                child: const FaIcon(FontAwesomeIcons.userSecret, size: 18))
          ],
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: const Text("Number of players"),
        ),
      ],
    );
  }
}
