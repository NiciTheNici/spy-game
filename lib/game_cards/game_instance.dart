import 'package:spy_game/game_cards/cards_widget.dart';

enum CardType {
  normal,
  spy,
  unknown,
}

class GameInstance {
  CardType activeCard = CardType.unknown; // enum of active card type
  List<CardType> cards = [];
  int activeCardIndex = 0;
  late CardsWidget cardWidget;

  GameInstance(context) {
    cardWidget = CardsWidget(
        context: context, onCardClick: () {}, country: getRandomCountry());
  }

  generateCardWidgets(settings) {
    List.generate(settings.currentNumberOfPlayers, (i) {
      cards.add(CardType.normal);
    });
    List.generate(settings.currentNumberOfSpies, (i) {
      cards.add(CardType.spy);
    });
    cards.shuffle();
    activeCard = CardType.unknown;
  }

  nextCard() {
    activeCard = cards[activeCardIndex];
    activeCardIndex++;
  }

  String getRandomCountry() {
    return "the dev fucked something up";
  }

  getCurrentCard() {
    switch (activeCard) {
      case CardType.normal:
        return cardWidget.earth();
      case CardType.spy:
        return cardWidget.userSecret();
      case CardType.unknown:
        return cardWidget.question();
    }
  }
}
