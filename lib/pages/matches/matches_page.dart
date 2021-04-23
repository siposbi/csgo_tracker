import 'package:csgo_tracker/materials/custom_colors.dart';
import 'package:csgo_tracker/models/match_model.dart';
import 'package:csgo_tracker/pages/matches/add_new_match_page.dart';
import 'package:csgo_tracker/pages/matches/match_card.dart';
import 'package:csgo_tracker/services/database_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MatchesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: StreamBuilder<List<MatchModel>>(
              stream: context.read<DatabaseService>().getMatches(),
              builder: (context, snapshot) {
                if (snapshot.hasError || !snapshot.hasData) {
                  print("snapshot error: ${snapshot.error}");
                  return Center(child: Text("Something went wrong"));
                }

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
                  itemBuilder: (_, index) => MatchCard(matches[index]),
                );
              })),
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
