import 'package:flutter/material.dart';
import 'package:mychat/model/Auth.dart';
class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final googleSignin googleInstance = new googleSignin();
  @override
  Widget build(BuildContext context) {
       return ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 65.0),
              child: Container(
                  width: 100.0,
                  height: 100.0,
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: new NetworkImage(
                              "https://upload.wikimedia.org/wikipedia/commons/thumb/8/81/Salman_Khan_filmfare.jpg/330px-Salman_Khan_filmfare.jpg")
                      )
                  )),
            ),

            Text(
              'User name',
              textAlign: TextAlign.center,

            ),

            RaisedButton(
              onPressed: (){
                googleInstance.signOutGoogle();
              },
              child: Text('Log out',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
//            const Divider(
//              color: Colors.teal,
//              height: 10,
//              thickness: 2,
//              indent: 20.0,
//              endIndent: 20.0,
//            ),


          ],
        );

  }
}
