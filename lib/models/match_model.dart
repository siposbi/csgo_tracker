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

  MatchModel.fromJson(Map<String, dynamic> json)
      : this(
            createdAt: json['createdAt'].toDate(),
            gameDate: json['gameDate'].toDate(),
            map: json['map'],
            roundsWon: json['roundsWon'],
            roundsLost: json['roundsLost'],
            numberOfKills: json['numberOfKills'],
            numberOfAssists: json['numberOfAssists'],
            numberOfDeaths: json['numberOfDeaths']);

  Map<String, dynamic> toJson() {
    return {
      'createdAt': createdAt,
      'gameDate': gameDate,
      'map': map,
      'numberOfKills': numberOfKills,
      'numberOfDeaths': numberOfDeaths,
      'numberOfAssists': numberOfAssists,
      'roundsLost': roundsLost,
      'roundsWon': roundsWon,
    };
  }
}
