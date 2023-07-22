import 'package:firebase_core/firebase_core.dart';
import 'package:firebaseproject/models/user.dart';
import 'package:firebaseproject/screens/wrapper.dart';
import 'package:firebaseproject/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  print('-- WidgetsFlutterBinding.ensureInitialized');
  await Firebase.initializeApp(options: FirebaseOptions(
    apiKey: "AIzaSyCzySRWxUyBzIV9PkHPWxptsZKZH_LFJkA", // Your apiKey
    appId: "XXX", // Your appId
    messagingSenderId: "XXX", // Your messagingSenderId
    projectId: "shae-7af88", // Your projectId
  ));
  print('-- main: Firebase.initializeApp');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserM?>.value(value: Authservice().user,
    initialData: null,
    child: MaterialApp(
      home: Wrapper(),
    ));
  }
}