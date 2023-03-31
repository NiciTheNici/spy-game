import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CardsWidget {
  BuildContext context;
  final VoidCallback onCardClick;
  CardsWidget({required this.context, required this.onCardClick});

  Widget userSecret() {
    return cardWidget(FontAwesomeIcons.userSecret, onCardClick, "Youre sus");
  }

  Widget earth() {
    return cardWidget(FontAwesomeIcons.earthAmericas, onCardClick, "panama");
  }

  Widget question() {
    return cardWidget(FontAwesomeIcons.question, onCardClick, "Tap to turn");
  }

  Widget cardWidget(roleIcon, cardTapped, cardText) {
    return Center(
      child: Card(
        clipBehavior: Clip.hardEdge,
        margin: const EdgeInsets.symmetric(horizontal: 30),
        child: InkWell(
          splashColor: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
          onTap: () {
            cardTapped();
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
                              roleIcon,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.only(bottom: 50),
                          child: Text(
                            cardText,
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
}
