class MatchModel {
  DateTime dateTime;
  String map;
  int roundsWon, roundsLost, numberOfKills, numberOfAssists, numberOfDeaths;

  double get killsPerDeathsRatio => numberOfKills/numberOfDeaths;

  MatchModel(this.dateTime, this.map, this.roundsWon, this.roundsLost, this.numberOfKills,
      this.numberOfAssists, this.numberOfDeaths);
}
