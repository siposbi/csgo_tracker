import 'package:csgo_tracker/materials/custom_colors.dart';
import 'package:csgo_tracker/models/match_model.dart';
import 'package:csgo_tracker/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MatchCard extends StatelessWidget {
  final MatchModel matchModel;

  MatchCard(this.matchModel);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0))),
      color: CustomColors.CARD_COLOR,
      child: Padding(
        padding: const EdgeInsets.only(
            top: 8.0, bottom: 8.0, right: 12.0, left: 12.0),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
          child: Theme(
            data: ThemeData(dividerColor: Colors.transparent),
            child: ExpansionTile(
              title: expansionTitle(matchModel),
              backgroundColor: CustomColors.CARD_COLOR,
              children: [expansionBody(matchModel, context)],
            ),
          ),
        ),
      ),
    );
  }

  Widget expansionTitle(match) => Row(
        children: [
          Image.asset(
            'images/${match.map}.png',
            width: 64,
            height: 64,
          ),
          Spacer(),
          Text(
            '${match.roundsWon.toString()} - ${match.roundsLost.toString()}',
            style: TextStyle(
              color: match.roundsWon >= match.roundsLost
                  ? Colors.green
                  : Colors.red,
              fontSize: 36.0,
            ),
          ),
          Spacer(),
        ],
      );

  Widget expansionBody(match, BuildContext context) =>
      Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        IntrinsicHeight(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                statColumn('Kills', match.numberOfKills.toString()),
                VerticalDivider(
                  color: CustomColors.PRIMARY_COLOR,
                  thickness: 2,
                  width: 3,
                ),
                statColumn('Assists', match.numberOfAssists.toString()),
                VerticalDivider(
                  color: CustomColors.PRIMARY_COLOR,
                  thickness: 2,
                  width: 3,
                ),
                statColumn(
                  'Deaths',
                  match.numberOfDeaths.toString(),
                ),
                VerticalDivider(
                  color: CustomColors.PRIMARY_COLOR,
                  thickness: 2,
                  width: 3,
                ),
                statColumn(
                  'K/D',
                  match.killsPerDeathsRatio.toStringAsFixed(2),
                ),
              ],
            ),
          ),
        ),
        ElevatedButton(
            child: Text(
              'Delete',
              style: TextStyle(
                fontSize: 24.0,
              ),
            ),
            style: ElevatedButton.styleFrom(
                primary: Colors.red,
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                  Radius.circular(16.0),
                ))),
            onPressed: () =>
                context.read<DatabaseService>().deleteMatch(match)),
      ]);

  Widget statColumn(title, text) => Column(
        children: [
          Text(
            title,
            style: TextStyle(
              color: CustomColors.PRIMARY_COLOR,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          Text(
            text,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
          ),
        ],
      );
}
