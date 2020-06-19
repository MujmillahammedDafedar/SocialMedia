import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class Post extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:new AppBar(
        backgroundColor: Colors.teal,
        centerTitle: true,
        actions: <Widget>[
          // action button

          // action button
        ],
        title: new Text('Homepage'
        ),
      ),
      body:CreateNewPost(),
    );
  }
}


class CreateNewPost extends StatefulWidget {
  @override
  _CreateNewPostState createState() => _CreateNewPostState();
}

class _CreateNewPostState extends State<CreateNewPost> {
  File _image;
  @override
  void initState() {
    super.initState();
  }

  void open_camera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  void open_gallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  final _PostKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return Form(
      key: _PostKey,
      child: Column(children: <Widget>[
        TextFormField(
          minLines: null,
          decoration: InputDecoration(
              border: InputBorder.none, hintText: 'What do you want to share knowledge'),
          // The validator receives the text that the user has entered.
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
        ),
        Container(
          color: Colors.black12,
          height: 100.0,
          width: 500.0,
          child: _image == null ? Text("Still waiting!") : Image.file(_image, width: 200.0, height: 200.0,),
        ),
        FlatButton(
          color: Colors.deepOrangeAccent,
          child: Text(
            "Open Camera",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            open_camera();
          },
        ),
        FlatButton(
          color: Colors.limeAccent,
          child: Text(
            "Open Gallery",
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () {
            open_gallery();
          },
        )
      ]),
    );
  }
}
