import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CardsWidget {
  BuildContext context;
  final VoidCallback onCardClick;
  CardsWidget({required this.context, required this.onCardClick});

  Widget userSecret() {
    return cardWidget(FontAwesomeIcons.userSecret, onCardClick);
  }

  Widget earth() {
    return cardWidget(FontAwesomeIcons.earthAmericas, onCardClick);
  }

  Widget question() {
    return cardWidget(FontAwesomeIcons.question, onCardClick);
  }

  Widget cardWidget(roleIcon, cardTapped) {
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
                            margin: const EdgeInsets.all(10),
                            child: FaIcon(
                              roleIcon,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                      ),
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
