import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseproject/models/user.dart';
import 'package:firebaseproject/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_database/firebase_database.dart';

class Authservice extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // create user object based on FirebaseUser
  UserM? _userFromFirebaseUser(User? user){
    if(user!=null){
      return UserM(uid: user.uid);
    }
    else{
      return null;
    }
  }
  // auth change user stream
  Stream<UserM?> get user{
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  // sign in anonymous
  Future signInAnon() async {
   try{
     UserCredential result = await _auth.signInAnonymously();
     User? user = result.user;
     return _userFromFirebaseUser(user);
   }
   catch(e){
     print(e.toString());
     return null;
   }
}

  // sign in email password
  Future signInWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user);
    }
    catch(e){
      print(e);
      return null;
    }
  }

  // registar with email password
    Future registerWithEmailAndPassword(String email, String password) async{
      try{
        UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
        User? user = result.user;
        await DatabaseService(uid: user!.uid).updateUserData("sugars", "name", 100);
        return _userFromFirebaseUser(user);
      }
      catch(e){
        print(e);
        return null;
      }
    }

  // sign out
  Future signOut() async{
    try{
      return await _auth.signOut();
    }
    catch(e){
      print(e.toString());
    }
  }

}