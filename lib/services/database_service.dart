import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class DatabaseService {
  final FirebaseFirestore _db;
  final BuildContext _context;
  late String? uid = _context.read<User?>()!.uid;

  DatabaseService(this._db, this._context);

  Stream<QuerySnapshot> getMatches() {
    return _db.collection('test').snapshots();
  }
}
