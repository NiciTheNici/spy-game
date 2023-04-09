import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'game_settings_controller.dart';

class GameSettingsWidget {
  GameSettings controller;
  GameSettingsWidget({required this.controller});

  Widget settingsScaffold(BuildContext context, widget) {
    return GestureDetector(
      // TODO also fix back button that currently doesnt unfocus
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      behavior: HitTestBehavior.translucent,
      child: Align(
        child: Column(
          children: [
            Container(
                alignment: Alignment.topCenter,
                margin: const EdgeInsets.only(top: 100),
                child:
                    Text(widget.title, style: const TextStyle(fontSize: 32))),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              child: Divider(
                color: Theme.of(context).colorScheme.primary,
                thickness: 5,
              ),
            ),
            settingsWidget(context),
          ],
        ),
      ),
    );
  }

  Widget settingsWidget(context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: singleSettingRow(
                  context,
                  FontAwesomeIcons.users,
                  "Number of players",
                  controller.currentNumberOfPlayers, (value) {
                controller.currentNumberOfPlayers = value;
              }),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: singleSettingRow(context, FontAwesomeIcons.userSecret,
                  "Number of spies", controller.currentNumberOfSpies, (value) {
                controller.currentNumberOfSpies = value;
              }),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: singleSettingRow(context, FontAwesomeIcons.stopwatch,
                  "Time limit (TODO)", controller.currentTimeLimit, (value) {
                controller.currentTimeLimit = value;
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
    final textFieldFocusNode = FocusNode();

    return GestureDetector(
      onTap: () {
        textFieldFocusNode.requestFocus();
      },
      behavior: HitTestBehavior.translucent,
      child: Container(
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
                    focusNode: textFieldFocusNode,
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
      ),
    );
  }
}
