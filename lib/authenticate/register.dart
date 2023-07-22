import 'package:firebaseproject/shared/loading.dart';
import 'package:flutter/material.dart';
import '../services/auth.dart';
import '../shared/constants.dart';

class Register extends StatefulWidget {
  final Function toggleView ;
  Register({required this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final Authservice _auth = Authservice();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String email = '';
  String password = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    return loading? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text("Register to Shae"),
        actions: <Widget>[
        FlatButton.icon(
            onPressed: () {
              widget.toggleView();
            },
            icon: Icon(Icons.person),
            label: Text('Sign In'))
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
                  child: Text('Register', style: TextStyle(color: Colors.black),),
                  onPressed: () async{
                    if(_formKey.currentState!.validate()){
                      setState(() {
                        loading=true;
                      });
                      dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                      if(result==null){
                        setState(() {
                          error = 'Please supply a valid Email';
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
