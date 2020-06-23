import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mychat/screens/homepage.dart';
import 'package:path/path.dart' as Path;
import 'package:mychat/model/Auth.dart';

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
  String _uploadedFileURL;
  String post_content;
 final googleSignin gb = new googleSignin();

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
  Future uploadFile() async {
    _PostKey.currentState.save();
    print(':This is email id:$email');
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('post_images/${Path.basename(_image.path)}');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
        storageReference.getDownloadURL().then((fileURL) {
          setState(() {
            _uploadedFileURL = fileURL;

          });
    });
    print('File Uploaded: $_uploadedFileURL');

    Firestore.instance.collection('post_materials').document()
        .setData({
      'post_by' : '$email', 'image_location':'$_uploadedFileURL', 'content' : '$post_content','name':'$name', 'photo' : '$imageUrl'
    }).whenComplete(() =>
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text('Successfully posted'), backgroundColor: Colors.green,)),

    );
//    Navigator.push(
//      context,
//      MaterialPageRoute(
//          builder: (BuildContext context) => new Homepage()),);


  }

  final _PostKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return Form(
      key: _PostKey,
      child: Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: TextFormField(
              autofocus: false,
              maxLines: null,
              keyboardType: TextInputType.text,
              minLines: null,
              decoration: InputDecoration(
                  border: new OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.teal)),
                  hintText: 'Do you want to share knowledge?'
              ),

              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              onSaved: (value) => post_content = value,

            ),
          ),
        ),

        Container(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                IconButton(
                  color: Colors.deepOrangeAccent,
                  icon: Icon(Icons.camera_alt),
                  tooltip: 'Open camera',
                  onPressed: () {
                    open_camera();
                  },
                ),
                IconButton(
                  color: Colors.deepOrangeAccent,
                  icon: Icon(Icons.collections),
                  onPressed: () {
                    open_gallery();
                  },
                ),
              ],
            ),
          ),
          
        ),
        Container(
          color: Colors.teal.shade50,
          height: 100.0,
          width: 500.0,
          child: _image == null ? Text("Still waiting!") : Image.file(_image, width: 200.0, height: 200.0,),
        ),
        
        FlatButton(
          color: Colors.red,
          child: Text('Post'),
           onPressed: uploadFile,
        )
      ]),
    );
  }
}
