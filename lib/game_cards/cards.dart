class Cards {
  CardType activeCard = CardType.unknown; // enum of active card type
  List<CardType> cards = [];
  int activeCardIndex = 0;

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

enum CardType {
  normal,
  spy,
  unknown,
}
