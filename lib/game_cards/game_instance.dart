enum CardType {
  normal,
  spy,
  unknown,
}

class GameInstance {
  CardType activeCard = CardType.unknown; // enum of active card type
  List<CardType> cards = [];
  int activeCardIndex = 0;
  String randomCountry = "the dev fucked something up";

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
}
