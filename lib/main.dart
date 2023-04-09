import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spy_game/game_cards/cards_widget.dart';
import 'package:spy_game/game_settings/game_settings_controller.dart';
import 'package:spy_game/game_settings/game_settings_widget.dart';
import 'package:spy_game/game_cards/game_instance.dart';

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

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Widgets activeWidget; // enum of active widget

  late GameSettingsController
      settings; // literally just houses the settings variables
  late Widget settingsWidget; // settings view

  GameInstance gameInstance = GameInstance();
  late CardsWidget cardWidgetBuilder; // instance of CardsWidget
  late Widget currentCardWidget; // currrent card view

  late IconData floatButtonIcon;

  Widget getActiveWidget() {
    switch (activeWidget) {
      case Widgets.settings:
        return settingsWidget;
      case Widgets.cardSelect:
        return getCurrentCard();
    }
  }

  @override
  void initState() {
    super.initState();
    settings = GameSettingsController();
    _loadControllerData();
    activeWidget = Widgets.settings;
    floatButtonIcon = Icons.play_arrow_rounded;
  }

  @override
  Widget build(BuildContext context) {
    cardWidgetBuilder = CardsWidget(
        context: context,
        onCardClick: onCardClick,
        country: gameInstance.randomCountry);
    settingsWidget = GameSettingsWidget(controller: settings)
        .settingsScaffold(context, widget);
    currentCardWidget = cardWidgetBuilder.question();
    return Scaffold(
      body: getActiveWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (activeWidget == Widgets.settings) {
              startNewGame();
            } else {
              backToSettings();
            }
          });
        },
        child: Icon(floatButtonIcon),
      ),
    );
  }

  startNewGame() {
    _saveControllerData();
    gameInstance.generateCardWidgets(settings);
    activeWidget = Widgets.cardSelect;
    floatButtonIcon = Icons.loop;
  }

  getCurrentCard() {
    switch (gameInstance.activeCard) {
      case CardType.normal:
        return cardWidgetBuilder.earth();
      case CardType.spy:
        return cardWidgetBuilder.userSecret();
      case CardType.unknown:
        return cardWidgetBuilder.question();
    }
  }

  backToSettings() {
    gameInstance = GameInstance();
    activeWidget = Widgets.settings;
    floatButtonIcon = Icons.play_arrow_rounded;
  }

  onCardClick() {
    setState(() {
      if (gameInstance.activeCard != CardType.unknown) {
        if (gameInstance.activeCardIndex == gameInstance.cards.length) {
          backToSettings();
        }
        gameInstance.activeCard = CardType.unknown;
      } else {
        gameInstance.nextCard();
      }
    });
  }

  _saveControllerData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('numPlayers', settings.currentNumberOfPlayers);
    prefs.setInt('numSpies', settings.currentNumberOfSpies);
    // ...
  }

  _loadControllerData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    settings.currentNumberOfPlayers = prefs.getInt('numPlayers') ?? 5;
    settings.currentNumberOfSpies = prefs.getInt('numSpies') ?? 1;
    // ...
  }
}
