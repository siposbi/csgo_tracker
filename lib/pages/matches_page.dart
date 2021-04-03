import 'package:csgo_tracker/materials/custom_colors.dart';
import 'package:csgo_tracker/models/match_model.dart';
import 'package:csgo_tracker/pages/add_new_match_page.dart';
import 'package:csgo_tracker/services/database_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MatchesPage extends StatelessWidget {
  Widget myColumn(title, text) => Column(
        children: [
          Text(
            title,
            style: TextStyle(
              color: CustomColors.PRIMARY_COLOR,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 12.0),
            child: Text(
              text,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
          ),
        ],
      );

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
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                myColumn('Kills', match.numberOfKills.toString()),
                VerticalDivider(
                  color: CustomColors.PRIMARY_COLOR,
                  thickness: 2,
                  width: 3,
                ),
                myColumn('Assists', match.numberOfAssists.toString()),
                VerticalDivider(
                  color: CustomColors.PRIMARY_COLOR,
                  thickness: 2,
                  width: 3,
                ),
                myColumn(
                  'Deaths',
                  match.numberOfDeaths.toString(),
                ),
                VerticalDivider(
                  color: CustomColors.PRIMARY_COLOR,
                  thickness: 2,
                  width: 3,
                ),
                myColumn(
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<List<MatchModel>>(
            stream: context.read<DatabaseService>().getMatches(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.data!.isEmpty) {
                return Center(
                    child: Text(
                  'You don\'t have any matches yet, try adding some first.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: CustomColors.PRIMARY_COLOR,
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ));
              }
              final matches = snapshot.data!;
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (_, index) => Card(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(16.0))),
                        color: CustomColors.CARD_COLOR,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(16.0)),
                            child: Theme(
                              data: ThemeData(dividerColor: Colors.transparent),
                              child: ExpansionTile(
                                title: expansionTitle(matches[index]),
                                backgroundColor: CustomColors.CARD_COLOR,
                                children: [
                                  expansionBody(matches[index], context)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ));
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => AddMatch()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
