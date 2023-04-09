class GameSettings {
  int currentNumberOfPlayers;
  int currentNumberOfSpies;
  int currentTimeLimit;

  GameSettings(
      {this.currentNumberOfPlayers = 4,
      this.currentNumberOfSpies = 1,
      this.currentTimeLimit = 0});
}
