import 'package:csgo_tracker/models/match_model.dart';
import 'package:csgo_tracker/pages/statistics/statistics_card.dart';
import 'package:csgo_tracker/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatisticsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: FutureBuilder<List<MatchModel>>(
          future: context.read<DatabaseService>().getMatchesForStats(),
          builder:
              (BuildContext context, AsyncSnapshot<List<MatchModel>> snapshot) {
            if (snapshot.hasError || !snapshot.hasData) {
              return Center(child: Text("Something went wrong"));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            var kills = snapshot.data!.fold(
                0, (int sum, MatchModel item) => sum + item.numberOfKills);
            var deaths = snapshot.data!.fold(
                0, (int sum, MatchModel item) => sum + item.numberOfDeaths);
            var assists = snapshot.data!.fold(
                0, (int sum, MatchModel item) => sum + item.numberOfAssists);
            var kpd = deaths == 0 ? 0 : kills / deaths;
            var matches = snapshot.data!.length;
            var won = snapshot.data!
                .where((element) => element.roundsWon >= element.roundsLost)
                .length;
            var lost = snapshot.data!
                .where((element) => element.roundsWon < element.roundsLost)
                .length;
            var wlp = matches == 0 ? 0 : won / matches;

            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                StatisticsPageCard(title: 'Kills', text: kills.toString()),
                StatisticsPageCard(title: 'Deaths', text: deaths.toString()),
                StatisticsPageCard(title: 'Assists', text: assists.toString()),
                StatisticsPageCard(title: 'K/D', text: kpd.toStringAsFixed(2)),
                StatisticsPageCard(title: 'Matches', text: matches.toString()),
                StatisticsPageCard(title: 'Won', text: won.toString()),
                StatisticsPageCard(title: 'Lost', text: lost.toString()),
                StatisticsPageCard(
                    title: 'Win %', text: wlp.toStringAsFixed(2)),
              ],
            );
          }),
    );
  }
}
