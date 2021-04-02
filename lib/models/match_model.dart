class MatchModel {
  DateTime dateTime;
  String map;
  int roundsWon, roundsLost, numberOfKills, numberOfAssists, numberOfDeaths;

  double get killsPerDeathsRatio => numberOfKills / numberOfDeaths;

  MatchModel(
      {required this.dateTime,
      required this.map,
      required this.roundsWon,
      required this.roundsLost,
      required this.numberOfKills,
      required this.numberOfAssists,
      required this.numberOfDeaths});

  factory MatchModel.fromMap(Map<String, dynamic> data) {
    return MatchModel(
        map: data['map'],
        dateTime: data['dateTime'].toDate(),
        roundsWon: data['roundsWon'],
        roundsLost: data['roundsLost'],
        numberOfKills: data['numberOfKills'],
        numberOfAssists: data['numberOfAssists'],
        numberOfDeaths: data['numberOfDeaths']);
  }

  @override
  String toString() {
    return 'MatchModel{dateTime: $dateTime, map: $map, roundsWon: $roundsWon, roundsLost: $roundsLost, numberOfKills: $numberOfKills, numberOfAssists: $numberOfAssists, numberOfDeaths: $numberOfDeaths}';
  }
}
