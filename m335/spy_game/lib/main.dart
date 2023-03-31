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

enum CardType {
  normal,
  spy,
  unknown,
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
  late CardType activeCard;
  List<CardType> cards = [];
  int activeCardIndex = 0;

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
    controller = GameSettingsController();
    activeWidget = Widgets.settings;
    floatButtonIcon = Icons.play_arrow_rounded;
  }

  @override
  Widget build(BuildContext context) {
    cardWidgetBuilder = CardsWidget(context: context, onCardClick: onCardClick);
    settingsWidget = GameSettingsWidget(controller: controller)
        .settingsScaffold(context, widget);
    currentCardWidget = cardWidgetBuilder.question();
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
              backToSettings();
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

  getCurrentCard() {
    switch (activeCard) {
      case CardType.normal:
        return cardWidgetBuilder.earth();
      case CardType.spy:
        return cardWidgetBuilder.userSecret();
      case CardType.unknown:
        return cardWidgetBuilder.question();
    }
  }

  clearCardWidgets() {
    cards = [];
  }

  generateCardWidgets() {
    List.generate(controller.currentNumberOfPlayers, (i) {
      cards.add(CardType.normal);
    });
    List.generate(controller.currentNumberOfSpies, (i) {
      cards.add(CardType.spy);
    });
    // print("there are " + cards.length.toString() + " cards");
    cards.shuffle();
    activeCard = CardType.unknown;
  }

  nextCard() {
    print(activeCardIndex);
    print(cards.length);
    activeCard = cards[activeCardIndex];
    activeCardIndex++;
  }

  backToSettings() {
    clearCardWidgets();
    activeWidget = Widgets.settings;
    floatButtonIcon = Icons.play_arrow_rounded;
    activeCardIndex = 0;
  }

  onCardClick() {
    setState(() {
      if (activeCard != CardType.unknown) {
        print("spy or world card clicked");
        if (activeCardIndex == cards.length) {
          backToSettings();
        }
        activeCard = CardType.unknown;
      } else {
        print("unknown card clicked");
        nextCard();
      }
    });
  }
}
