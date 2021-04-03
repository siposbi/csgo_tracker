class MatchModel {
  DateTime gameDate, createdAt;
  String map;
  int roundsWon, roundsLost, numberOfKills, numberOfAssists, numberOfDeaths;

  double get killsPerDeathsRatio => numberOfKills / numberOfDeaths;

  MatchModel(
      {required this.createdAt,
      required this.gameDate,
      required this.map,
      required this.roundsWon,
      required this.roundsLost,
      required this.numberOfKills,
      required this.numberOfAssists,
      required this.numberOfDeaths});

  factory MatchModel.fromMap(Map<String, dynamic> data) {
    return MatchModel(
        createdAt: data['createdAt'].toDate(),
        gameDate: data['gameDate'].toDate(),
        map: data['map'],
        roundsWon: data['roundsWon'],
        roundsLost: data['roundsLost'],
        numberOfKills: data['numberOfKills'],
        numberOfAssists: data['numberOfAssists'],
        numberOfDeaths: data['numberOfDeaths']);
  }
}
