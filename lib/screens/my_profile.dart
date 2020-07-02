import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mychat/model/Auth.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../main.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool _saving = false;

  // ignore: must_call_super
  void initState(){
    inputData();
    print('called');
  }
  final googleSignin googleInstance = new googleSignin();
  String username;
  String imageUrl;
  String email;



  void inputData() async {

    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    if(user.displayName!=null){
      username = user.displayName;
      imageUrl = user.photoUrl;
      email = user.email;
    }
}


  Widget _buildCoverImage(Size screenSize) {
    return Container(
      height: screenSize.height / 2.6,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage('$imageUrl'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return Center(
      child: Container(
        width: 140.0,
        height: 140.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(80.0),
          image: DecorationImage(
            image: NetworkImage('$imageUrl'),
            fit: BoxFit.cover,
          ),
          border: Border.all(
            color: Colors.white,
            width: 10.0,
          ),
        ),
      ),
    );
  }

  Widget _buildFullName() {
    TextStyle _nameTextStyle = TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black,
      fontSize: 28.0,
      fontWeight: FontWeight.w700,
    );

    return Text(
      '$username',
      style: _nameTextStyle,
    );
  }

  Widget _buildStatus(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Text(
        '_status',
        style: TextStyle(
          fontFamily: 'Spectral',
          color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String count) {
    TextStyle _statLabelTextStyle = TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black,
      fontSize: 16.0,
      fontWeight: FontWeight.w200,
    );

    TextStyle _statCountTextStyle = TextStyle(
      color: Colors.black54,
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          count,
          style: _statCountTextStyle,
        ),
        Text(
          label,
          style: _statLabelTextStyle,
        ),
      ],
    );
  }

//  Widget _buildStatContainer() {
//    return Container(
//      height: 60.0,
//      margin: EdgeInsets.only(top: 8.0),
//      decoration: BoxDecoration(
//        color: Color(0xFFEFF4F7),
//      ),
//      child: Row(
//        mainAxisAlignment: MainAxisAlignment.spaceAround,
//        children: <Widget>[
//          _buildStatItem("Followers", _followers),
//          _buildStatItem("Posts", _posts),
//          _buildStatItem("Scores", _scores),
//        ],
//      ),
//    );
//  }

  Widget _buildBio(BuildContext context) {
    TextStyle bioTextStyle = TextStyle(
      fontFamily: 'Spectral',
      fontWeight: FontWeight.w400,
      //try changing weight to w500 if not thin
      fontStyle: FontStyle.italic,
      color: Color(0xFF799497),
      fontSize: 16.0,
    );

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: EdgeInsets.all(8.0),
      child: Text(
        '_bio',
        textAlign: TextAlign.center,
        style: bioTextStyle,
      ),
    );
  }

  Widget _buildSeparator(Size screenSize) {
    return Container(
      width: screenSize.width / 1.6,
      height: 2.0,
      color: Colors.black54,
      margin: EdgeInsets.only(top: 4.0),
    );
  }

  Widget _buildGetInTouch(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: EdgeInsets.only(top: 8.0),
      child: Text(
        "Get in Touch with",
        style: TextStyle(fontFamily: 'Roboto', fontSize: 16.0),
      ),
    );
  }

  Widget _buildButtons() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: <Widget>[
//          Expanded(
//            child: InkWell(
//              onTap: () => print("followed"),
//              child: Container(
//                height: 40.0,
//                decoration: BoxDecoration(
//                  border: Border.all(),
//                  color: Color(0xFF404A5C),
//                ),
//                child: Center(
//                  child: Text(
//                    "FOLLOW",
//                    style: TextStyle(
//                      color: Colors.white,
//                      fontWeight: FontWeight.w600,
//                    ),
//                  ),
//                ),
//              ),
//            ),
//          ),
          SizedBox(width: 10.0),
          Expanded(
            child: InkWell(
              onTap: () => print("Message"),
              child: Container(
                height: 40.0,
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: FlatButton(
                      onPressed: () {
                        FirebaseAuth.instance.signOut().whenComplete(
                              () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      LoginPage(),
                                ),
                              ),
                            );
                      },
                      child: Text(
                        "LOGOUT",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _buildCoverImage(screenSize),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: screenSize.height / 6.4),
                  _buildProfileImage(),
                  _buildFullName(),
                  //_buildStatus(context),
                  //_buildStatContainer(),
                  //_buildBio(context),
                  _buildSeparator(screenSize),
                  SizedBox(height: 10.0),
                  // _buildGetInTouch(context),
                  SizedBox(height: 8.0),
                  _buildButtons(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
