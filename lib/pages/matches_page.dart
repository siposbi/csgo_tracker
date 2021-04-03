import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csgo_tracker/materials/custom_colors.dart';
import 'package:csgo_tracker/models/match_model.dart';
import 'package:csgo_tracker/pages/add_new_match_page.dart';
import 'package:csgo_tracker/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MatchesPage extends StatelessWidget {
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
                            child: ExpansionTile(
                              title: Row(
                                children: [
                                  SizedBox(
                                      height: 64,
                                      width: 64,
                                      child: Image.asset(
                                          'images/${matches[index].map}.png')),
                                  Spacer(),
                                  Text(
                                    '${matches[index].roundsWon.toString()} - ${matches[index].roundsLost.toString()}',
                                    style: TextStyle(
                                      color: matches[index].roundsWon >=
                                              matches[index].roundsLost
                                          ? Colors.green
                                          : Colors.red,
                                      fontSize: 36.0,
                                    ),
                                  ),
                                  Spacer(),
                                ],
                              ),
                              backgroundColor: CustomColors.CARD_COLOR,
                              children: [
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 16.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Column(
                                              children: [
                                                Text('Kills'),
                                                Text(matches[index]
                                                    .numberOfKills
                                                    .toString()),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Text('Assists'),
                                                Text(matches[index]
                                                    .numberOfAssists
                                                    .toString()),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Text('Deaths'),
                                                Text(matches[index]
                                                    .numberOfDeaths
                                                    .toString()),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Text('K/D'),
                                                Text(matches[index]
                                                    .killsPerDeathsRatio
                                                    .toStringAsFixed(2)),
                                              ],
                                            ),
                                          ],
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
                                                  borderRadius:
                                                      BorderRadius.all(
                                                Radius.circular(16.0),
                                              ))),
                                          onPressed: () {
                                            CollectionReference users =
                                                FirebaseFirestore.instance
                                                    .collection(
                                                        'users/${context.read<User?>()!.uid}/games');

                                            users.doc(matches[index].documentUrl).delete();
                                          }),
                                    ])
                              ],
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
