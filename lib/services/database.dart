import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseproject/models/shae.dart';
import 'package:firebaseproject/models/user.dart';

import '../models/user.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({ this.uid});
  // Collection Reference
  final CollectionReference shaeCollection = FirebaseFirestore.instance.collection('Shae');
  Future updateUserData(String sugars, String name, int strength) async {
    await shaeCollection.doc(uid).set({
      'sugars' : sugars,
      'name' : name,
      'strength' : strength,
    });
  }
  //Shae list from snapshot
  List<Shae> _shaeListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return Shae(name: doc.get('name') ?? '', sugars: doc.get('sugars') ?? '0', strength: doc.get('strength') ?? 0);
    }).toList();
  }
  // get shae stream
  Stream<List<Shae>> get ShaeG {
    return shaeCollection.snapshots().map(_shaeListFromSnapshot);
  }

  // UserData from snapshot
  UserData? _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(uid: uid, sugars: snapshot['sugars']?? '0', name: snapshot['name']?? '', strength: snapshot['strength']?? 100);
  }

  // get user doc stream
  Stream<UserData?> get userData{
    return shaeCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

}

