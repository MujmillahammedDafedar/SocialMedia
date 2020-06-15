import 'package:flutter/material.dart';
import 'package:mychat/model/Auth.dart';
import 'package:mychat/screens/homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
 final googleSignin gs = new googleSignin();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Column(
          children: <Widget>[
           RaisedButton(
             textColor: Colors.black,
             child: Text('Sign in with google'),
             onPressed: () {
               setState(() {
                 gs.signInWithGoogle().whenComplete(() =>
                     Navigator.push(
                         context,
                         MaterialPageRoute(
                             builder: (BuildContext context) => new Homepage()))
                 );
               });
             },
           ),
            ],
        ),
      ),
    );
  }
}