import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseproject/home/settings_form.dart';
import 'package:firebaseproject/models/shae.dart';
import 'package:firebaseproject/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebaseproject/services/database.dart';
import 'package:provider/provider.dart';
import 'package:firebaseproject/home/shae_list.dart';

class Home extends StatelessWidget {
  final Authservice _auth = Authservice();
  List<Shae> asd = []; // Just so Initial Value is not null and avoid red screen
  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20,horizontal: 60),
          child: SettingsForm(),
        );
      });
    }
    return StreamProvider<List<Shae>?>.value(
      value: DatabaseService().ShaeG,
      initialData: asd,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Shae Gill'),
          backgroundColor: Colors.brown[400],
          elevation: 0,
          actions: <Widget>[
            FlatButton.icon(onPressed: () async{
              await _auth.signOut();
            },
                icon: Icon(Icons.logout),
                label: Text('Log Out')),
            FlatButton.icon(onPressed: (){
              _showSettingsPanel();
            }, icon: Icon(Icons.settings), label: Text("Setting"))
          ],
        ),
        body: Container(
          decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/Day.jpg'))),
          child: ShaeList(),
        ),
      ),
    );
  }
}



