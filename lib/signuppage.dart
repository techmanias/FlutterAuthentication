import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reg/welcome.dart';
import 'dart:async';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

 String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                validator:(input) {
                  if(input.isEmpty){
                    return 'Email cant be empty';
                  }
                },
                onSaved:(input) => _email = input ,
                decoration: InputDecoration(
                  labelText:'Email',
                  labelStyle: TextStyle(color:Colors.deepOrange),
                ),
              ) ,
              SizedBox(height: 5.0),
              TextFormField(
                validator:(input) {
                  if(input.length < 6){
                    return 'your password must be atleast 6 characters';
                  }
                },
                onSaved:(input) => _password = input ,
                decoration: InputDecoration(
                  labelText:'Password',
                  labelStyle: TextStyle(color:Colors.deepOrange),
                ),
                obscureText: true,
              ) ,
              RaisedButton(
                onPressed:signUp,
                child: Text('Sign Up',
                 style: TextStyle(
                  color:Colors.white,
                ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  Future<void> signUp() async {
    final formState=_formKey.currentState;
    if(formState.validate()){
      formState.save();
      try{
        AuthResult user = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
        user.additionalUserInfo;
        Navigator.of(context).pop();
        Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
      }catch(e){
        print(e.message);
      }
    } 
  }
}    
