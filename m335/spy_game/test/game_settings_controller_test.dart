import 'package:flutter_test/flutter_test.dart';
import 'package:spy_game/game_settings/game_settings_controller.dart';

void main() {
  group('GameSettingsController', () {
    test('should initialize with default values', () {
      final controller = GameSettingsController();

      expect(controller.currentNumberOfPlayers, equals(4));
      expect(controller.currentNumberOfSpies, equals(1));
      expect(controller.currentTimeLimit, equals(0));
    });

    test('should initialize with provided values', () {
      final controller = GameSettingsController(
        currentNumberOfPlayers: 6,
        currentNumberOfSpies: 2,
        currentTimeLimit: 120,
      );

      expect(controller.currentNumberOfPlayers, equals(6));
      expect(controller.currentNumberOfSpies, equals(2));
      expect(controller.currentTimeLimit, equals(120));
    });

    test('should update values', () {
      final controller = GameSettingsController();

      controller.currentNumberOfPlayers = 8;
      controller.currentNumberOfSpies = 3;
      controller.currentTimeLimit = 180;

      expect(controller.currentNumberOfPlayers, equals(8));
      expect(controller.currentNumberOfSpies, equals(3));
      expect(controller.currentTimeLimit, equals(180));
    });
  });
}
