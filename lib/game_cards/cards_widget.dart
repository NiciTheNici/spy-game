import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'game_instance.dart';

class QuestionCard {
  IconData icon = FontAwesomeIcons.question;
  String text = "Tap to reveal your role";
}

class SpyCard implements QuestionCard {
  @override
  IconData icon = FontAwesomeIcons.userSecret;
  @override
  String text = "You are sus";
}

class CountryCard implements QuestionCard {
  @override
  IconData icon = FontAwesomeIcons.userSecret;
  @override
  String text;

  CountryCard({required this.text});
}

class _CardsWidget extends State<CardsWidget> {
  String country = "placeholder";

  @override
  void initState() {
    super.initState();
    country = widget.country;
  }

  @override
  Widget build(buildContext) {
    return Center(
      child: Card(
        clipBehavior: Clip.hardEdge,
        margin: const EdgeInsets.symmetric(horizontal: 30),
        child: InkWell(
          splashColor: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
          onTap: () {
            widget.gameInstance.nextCard();
          },
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 400,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Container(
                            margin: const EdgeInsets.all(5),
                            child: FaIcon(
                              activeCard().icon,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.only(bottom: 50),
                          child: Text(
                            activeCard().text,
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 20),
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  QuestionCard activeCard() {
    switch (widget.gameInstance.activeCard) {
      case CardType.normal:
        return CountryCard(text: widget.country);
      case CardType.spy:
        return SpyCard();
      case CardType.unknown:
        return QuestionCard();
    }
  }
}

class CardsWidget extends StatefulWidget {
  final BuildContext context;
  final GameInstance gameInstance;
  final String country;
  const CardsWidget(
      {super.key,
      required this.context,
      required this.gameInstance,
      required this.country});

  @override
  State<CardsWidget> createState() => _CardsWidget();
}
