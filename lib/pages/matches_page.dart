import 'package:csgo_tracker/materials/custom_colors.dart';
import 'package:csgo_tracker/models/match_model.dart';
import 'package:csgo_tracker/pages/add_new_match_page.dart';
import 'package:csgo_tracker/services/database_service.dart';
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
              return ListView.separated(
                itemBuilder: (_, index) =>
                    buildMatchCard(context, matches[index]),
                separatorBuilder: (_, index) => Divider(height: 0.5),
                itemCount: matches.length,
              );
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

  Widget buildMatchCard(BuildContext context, MatchModel match) {
    return Card(
      child: Row(
        children: [
          Image(image: AssetImage('images/de_cache.png')),
          Text(
            "${match.roundsWon} - ${match.roundsLost}",
            style: TextStyle(color: Colors.green),
          )
        ],
      ),
    );
  }
}
