import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csgo_tracker/models/match_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class DatabaseService {
  final FirebaseFirestore _db;
  final BuildContext _context;
  late String? uid = _context.read<User?>()!.uid;

  DatabaseService(this._db, this._context);

  Stream<List<MatchModel>> getMatches() {
    return _db
        .collection('users/$uid/games')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((e) => MatchModel.fromJson(e.data(), url: e.id))
            .toList());
  }

  Future<List<MatchModel>> getMatchesForStats() async {
    CollectionReference _collectionRef = _db.collection('users/$uid/games');
    QuerySnapshot querySnapshot = await _collectionRef.get();
    return querySnapshot.docs
        .map((e) => MatchModel.fromJson(e.data()))
        .toList();
  }

  Future<void> addMatch(MatchModel match) {
    CollectionReference users = _db.collection('users/$uid/games');
    return users.add(match.toJson());
  }

  Future<void> deleteMatch(MatchModel match) {
    CollectionReference users = _db.collection('users/$uid/games');
    return users.doc(match.documentUrl).delete();
  }
}
