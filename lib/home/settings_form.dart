import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseproject/models/user.dart';
import 'package:firebaseproject/services/database.dart';
import 'package:firebaseproject/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:firebaseproject/shared/constants.dart';
import 'package:provider/provider.dart';
class SettingsForm extends StatefulWidget {
  const SettingsForm({Key? key}) : super(key: key);

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0','1','2','3','4'];
  String? _currentName;
  String? _currentSugars;
  int? _currentStrength;
  @override
  Widget build(BuildContext context) {
    final userr = Provider.of<UserM?>(context);
    return StreamBuilder<UserData?>(
      stream: DatabaseService(uid: userr?.uid).userData,
      builder: (context,snapshot){
        if(snapshot.hasData){
          UserData? userData = snapshot.data;
          return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text('Update your Shae Settings.',style: TextStyle(fontSize: 18),),
                  SizedBox(height: 20,),
                  TextFormField(
                    initialValue: userData?.name,
                    validator: (val)=> val!.isEmpty ? 'Please enter a name':null,
                    decoration: TextInputDecoration.copyWith(hintText: 'Your Name'),
                    onChanged: (val)=>setState(() {
                      _currentName=val;
                    }),
                  ),
                  SizedBox(height: 20,),
                  DropdownButtonFormField(
                    decoration: TextInputDecoration,
                    value: _currentSugars ?? userData?.sugars,
                    items: sugars.map((sugar){
                      return DropdownMenuItem(
                        value: sugar,
                        child: Text('$sugar Sugars'),
                      );
                    }).toList(),
                    onChanged: (String? val)=> setState(() {
                      _currentSugars=val;
                    }),),
                  Slider(
                    label: 'Strength of Tea',
                    activeColor: Colors.brown[_currentStrength ?? 100],
                    inactiveColor: Colors.brown,
                    min: 100.0,
                    max: 900.0,
                    divisions: 8,
                    onChanged: (val){
                      setState(() {
                        _currentStrength = val.round();
                      });
                    },
                    value: (_currentStrength ?? userData?.strength)!.toDouble(),
                  ),
                  RaisedButton(onPressed: () async{
                    if(_formKey.currentState!.validate()){
                      print(_currentName);
                      print(_currentStrength);
                      print(_currentSugars);
                      if(_currentName == null){
                        _currentName = userData?.name;
                      }
                      if(_currentSugars==null){
                        _currentSugars=userData?.sugars;
                      }
                      if(_currentStrength==null){
                        _currentStrength= userData?.strength;
                      }
                      print(_currentName);
                      print(_currentStrength);
                      print(_currentSugars);
                      await DatabaseService(uid: userr?.uid).updateUserData(_currentSugars!, _currentName!, _currentStrength!);
                      Navigator.pop(context);
                    }


                    //DatabaseService(uid: userr?.uid).updateUserData(_currentSugars!, _currentName!, _currentStrength!);
                  },
                    color: Colors.pink[400],
                    child: Text('Update', style: TextStyle(color: Colors.white),),),
                ],
              ));
        }
        else{
          return Loading();
        }
      },
    );
  }
}