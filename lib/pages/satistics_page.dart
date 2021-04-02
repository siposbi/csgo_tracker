import 'package:flutter/material.dart';

class StatisticsPage extends StatelessWidget {
  final List<String> statList = [
    "Kills: 4215",
    "Deaths: 2860",
    "Assists: 667",
    "K/D: 1.1474",
    "Matches: 180",
    "Won: 90",
    "Lost: 90",
    "Win %: 50%",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
        crossAxisCount: 2,
        children: List.generate(statList.length,
            (index) => buildStatisticsCard(context, index)),
      ),
    );
  }

  Widget buildStatisticsCard(BuildContext context, int index) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text(statList[index]),
          ],
        ),
      ),
      margin: EdgeInsets.all(10.0),
      color: Colors.lightBlue,
    );
  }
}
