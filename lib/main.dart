import 'package:flutter/material.dart';
import 'package:mychat/model/Auth.dart';
import 'package:mychat/screens/homepage.dart';
import 'package:mychat/model/globals.dart' as globals;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.teal,
        body: LoginPage(),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
 final googleSignin gs = new googleSignin();
   if(globals.isLoggedIn == true){
         Navigator.push(
         context,
         MaterialPageRoute(
         builder: (BuildContext context) => new Homepage()),);

   } else{
        build(context);
 }
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