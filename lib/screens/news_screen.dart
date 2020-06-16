import 'package:flutter/material.dart';
class NewsFeed extends StatefulWidget {
  @override
  _NewsFeedState createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(bottom: 520.0),

          child: Align(
            alignment: Alignment.bottomCenter,
            child: FloatingActionButton.extended(

              icon: Icon(Icons.add),
              label: Text("Add post"),
            ),
            FloatingActionButton: FloatingActionButtonLocation.centerFloat,

          ),
        ),
      ],
    );
  }
}
