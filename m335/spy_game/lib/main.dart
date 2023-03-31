import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spy_game/game_cards/cards_widget.dart';
import 'package:spy_game/game_settings/game_settings_controller.dart';
import 'package:spy_game/game_settings/game_settings_widget.dart';

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

enum Widgets {
  settings,
  cardSelect,
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  // activeView;

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late GameSettingsController controller;
  late Widget settingsWidget;
  late CardsWidget cardWidgetBuilder;
  late Widgets activeWidget;
  late IconData floatButtonIcon;
  late Widget currentCardWidget;
  List<Widget> cards = [];

  Widget getActiveWidget() {
    switch (activeWidget) {
      case Widgets.settings:
        return settingsWidget;
      case Widgets.cardSelect:
        return currentCardWidget;
    }
  }

  @override
  void initState() {
    super.initState();
    controller = GameSettingsController();
    activeWidget = Widgets.settings;
    floatButtonIcon = Icons.play_arrow_rounded;
  }

  @override
  Widget build(BuildContext context) {
    cardWidgetBuilder = CardsWidget(context: context);
    settingsWidget = GameSettingsWidget(controller: controller)
        .settingsScaffold(context, widget);
    currentCardWidget = cardWidgetBuilder.question(cardClicked);
    return Scaffold(
      body: getActiveWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (activeWidget == Widgets.settings) {
              generateCardWidgets();
              activeWidget = Widgets.cardSelect;
              floatButtonIcon = Icons.loop;
            } else {
              clearCardWidgets();
              activeWidget = Widgets.settings;
              floatButtonIcon = Icons.play_arrow_rounded;
            }
          });

          // print(gameSettings.currentNumberOfPlayers);
          // print(gameSettings.currentNumberOfSpies);
          // print(gameSettings.currentTimeLimit);
        },
        child: Icon(floatButtonIcon),
      ),
    );
  }

  clearCardWidgets() {
    cards = [];
  }

  generateCardWidgets() {
    List.generate(controller.currentNumberOfPlayers, (i) {
      cards.add(cardWidgetBuilder.earth(cardClicked));
    });
    List.generate(controller.currentNumberOfSpies, (i) {
      cards.add(cardWidgetBuilder.userSecret(cardClicked));
    });
    print("there are " + cards.length.toString() + " cards");
    // cards.forEach(
    // (e) => print(e),
    // );
  }

  cardClicked() {
    setState(() {
      activeWidget = Widgets.settings;
    });
  }
}
