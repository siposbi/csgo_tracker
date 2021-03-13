import 'package:csgo_tracker/MatchModel.dart';
import 'package:flutter/material.dart';

class MatchesPage extends StatelessWidget {
  final List<MatchModel> dummyData = [
    MatchModel(DateTime.now(), 'de_cache', 1, 1, 1, 1, 1),
    MatchModel(DateTime.now(), 'de_cache', 2, 2, 2, 2, 2),
    MatchModel(DateTime.now(), 'de_cache', 3, 3, 3, 3, 3),
    MatchModel(DateTime.now(), 'de_cache', 4, 4, 4, 4, 4),
    MatchModel(DateTime.now(), 'de_cache', 5, 5, 5, 5, 5),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: dummyData.length,
        itemBuilder: (context, index) => buildMatchCard(context, index),
      ),
    );
  }

  Widget buildMatchCard(BuildContext context, int index) {
    MatchModel mm = dummyData[index];
    return Card(
      child: Row(
        children: [
          Image(image: AssetImage('images/de_cache.png')),
          Text("${mm.roundsWon} - ${mm.roundsLost}",
          style: TextStyle(color: Colors.green),)
        ],
      ),
    );
  }
}
