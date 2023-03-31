class GameSettingsController {
  int currentNumberOfPlayers;
  int currentNumberOfSpies;
  int currentTimeLimit;

  GameSettingsController(
      {this.currentNumberOfPlayers = 4,
      this.currentNumberOfSpies = 1,
      this.currentTimeLimit = 0});
}
