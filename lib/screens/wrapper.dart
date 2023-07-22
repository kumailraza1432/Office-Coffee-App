import 'package:firebaseproject/authenticate/authenticate.dart';
import 'package:firebaseproject/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userr = Provider.of<UserM?>(context);
    //return either home or authenticate
    if (userr==null){
      return Authenticate();
    }
    else{
      print(userr.uid);
      return Home();
    }
     }
}
