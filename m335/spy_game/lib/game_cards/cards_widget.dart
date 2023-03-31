import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CardsWidget {
  BuildContext context;
  CardsWidget({required this.context});

  Widget userSecret(Function cardTapped) {
    return cardWidget(FontAwesomeIcons.userSecret, cardTapped);
  }

  Widget earth(Function cardTapped) {
    return cardWidget(FontAwesomeIcons.earthAmericas, cardTapped);
  }

  Widget question(Function cardTapped) {
    return cardWidget(FontAwesomeIcons.question, cardTapped);
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
                          fit: BoxFit.fill,
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
