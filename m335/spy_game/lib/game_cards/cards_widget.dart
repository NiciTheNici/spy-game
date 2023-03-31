import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CardsWidget {
  Widget cardWidget() {
    return Center(
      child: Card(
        clipBehavior: Clip.hardEdge,
        margin: EdgeInsets.symmetric(horizontal: 30),
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            debugPrint('Card tapped.');
          },
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 400,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child: Container(
                            margin: EdgeInsets.all(10),
                            child: FaIcon(
                              FontAwesomeIcons.userSecret,
                              color: Colors.green,
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
