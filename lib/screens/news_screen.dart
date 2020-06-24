import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:photo_view/photo_view.dart';

class NewsFeed extends StatefulWidget {
  @override
  _NewsFeedState createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed> {
//   Future getImage(String fileURL) async{
//     StorageReference ref =
//     FirebaseStorage.instance.ref().child(fileURL);
//     String url = (await ref.getDownloadURL()).toString();
//     print('this is url : $url');
//     return url;
////     FirebaseStorage storage = new FirebaseStorage(
////         storageBucket: 'gs://students-c0be4.appspot.com'
////     );
////     StorageReference imageLink = storage.ref().child(fileURL);
////     print(imageLink);
//   }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('post_materials').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView(children: <Widget>[
            Column(
                children:
                    snapshot.data.documents.map((doc) => News(doc)).toList())
          ]);
        } else {
          return SizedBox();
        }
      },
    );
  }

  Card News(DocumentSnapshot doc) {
    return Card(
      //   child: Text(doc.toString()),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: InkWell(
          child: Column(
            children: <Widget>[
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                    "${doc.data['photo']}",
                  ),
                ),
                contentPadding: EdgeInsets.all(0),
                title: Text(
                  "${doc.data['name']}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Text(
                  "file",
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 11,
                  ),
                ),
              ),
              Text('${doc.data['content']}'),
//              PhotoView(
//                imageProvider: NetworkImage(
//              "${doc.data['image_location']}",
//                ),
//              ),
              InkWell(
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image.network(
                           "${doc.data['image_location']}",
                            width: 110.0, height: 110.0),
                      ),),
                  )
//                child: Image.network(
//                  "${doc.data['image_location']}",
//                  height: 170,
//
//                  width: MediaQuery.of(context).size.width,
//                  fit: BoxFit.cover,
//                ),
              ),
            ],
          ),
          onTap: () {},
        ),
      ),
    );
  }
}
