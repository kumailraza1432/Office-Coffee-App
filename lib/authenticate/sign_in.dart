import 'dart:html';
import 'package:firebaseproject/authenticate/register.dart';
import 'package:firebaseproject/services/auth.dart';
import 'package:firebaseproject/shared/loading.dart';
import 'package:flutter/material.dart';

import '../shared/constants.dart';

class SignIn extends StatefulWidget {
  final Function toggleView ;
  SignIn({required this.toggleView});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final Authservice _auth = Authservice();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;
  // textfield state
  String email = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text("Sign In to Shae"),
        actions: <Widget>[
          FlatButton.icon(
              onPressed: (){
                widget.toggleView();
              },
              icon: Icon(Icons.person),
              label: Text('Register'))
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20,horizontal: 50),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              TextFormField(
                decoration: TextInputDecoration.copyWith(hintText: 'Email'),
                validator: (val){
                  if(val!.isEmpty){
                    return 'Enter an Email';
                  }
                  else{
                    return null;
                  }
                },
                onChanged: (val){
                  setState(() {
                    email = val;
                  });
                },),
              SizedBox(height: 20,),
              TextFormField(
                decoration: TextInputDecoration.copyWith(hintText: 'Password'),
                validator: (val){
                  if(val!.length<6){
                    return 'Enter a Password 6+ chars long';
                  }
                  else{
                    return null;
                  }
                },
                obscureText: true,
                onChanged: (val){
                  setState(() {
                    password = val;
                  });
                },
              ),
              SizedBox(height: 20,),
              RaisedButton(
                color: Colors.pink,
                child: Text('Sign In', style: TextStyle(color: Colors.black),),
                onPressed: () async{
                  if(_formKey.currentState!.validate()){
                    setState(() {
                      loading = true;
                    });
                    dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                    if(result==null){
                      setState(() {
                        error = 'Could not Signed in with Credentials';
                        loading=false;
                      });
                    }
                  }
                },
              ),
              SizedBox(height: 12,),
              Text(error,style: TextStyle(color: Colors.red,fontSize: 14),)

            ],
          ),
        )),
    );
  }
}
