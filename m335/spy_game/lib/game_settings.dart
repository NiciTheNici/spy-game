import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GameSettings {
  int currentNumberOfPlayers;
  int currentNumberOfSpies;
  int currentTimeLimit;

  GameSettings(
      {this.currentNumberOfPlayers = 4,
      this.currentNumberOfSpies = 1,
      this.currentTimeLimit = 0});

  Widget settingsWidget(context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: singleSettingRow(context, FontAwesomeIcons.users,
                  "Number of players", currentNumberOfPlayers, (value) {
                currentNumberOfPlayers = value;
              }),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: singleSettingRow(context, FontAwesomeIcons.userSecret,
                  "Number of spies", currentNumberOfSpies, (value) {
                currentNumberOfSpies = value;
              }),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: singleSettingRow(context, FontAwesomeIcons.stopwatch,
                  "Time limit", currentTimeLimit, (value) {
                currentTimeLimit = value;
              }),
            ),
          ],
        )
      ],
    );
  }

  Widget singleSettingRow(
      context, icon, name, currentValue, ValueChanged<int> onChanged) {
    const rowPadding = EdgeInsets.symmetric(
      vertical: 16,
    );
    const borderMargin = EdgeInsets.symmetric(horizontal: 15);

    return Container(
      padding: rowPadding,
      child: Row(
        children: [
          Container(
            margin: borderMargin,
            alignment: Alignment.center,
            width: 20,
            child: FaIcon(
              icon,
              size: 18,
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(name),
          ),
          Expanded(
            child: Container(
              margin: borderMargin,
              alignment: Alignment.centerRight,
              // color: Colors.purple,
              child: SizedBox(
                width: 100,
                child: TextField(
                  decoration:
                      const InputDecoration.collapsed(hintText: "number"),
                  textAlign: TextAlign.right,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w200),
                  controller:
                      TextEditingController(text: currentValue.toString()),
                  onChanged: (value) {
                    onChanged(int.tryParse(value) ?? currentValue);
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
