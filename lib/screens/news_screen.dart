
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mychat/model/Auth.dart';

class NewsFeed extends StatefulWidget {
  @override
  _NewsFeedState createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed> {

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection('post_materials').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children:
                    snapshot.data.documents.map((doc) => News(doc)).toList(),
              );
            } else {
              return SizedBox();
            }
          },
        ),
      ],
    );
  }

  Future getUser(String email) async {
    final QuerySnapshot snapshot = await Firestore.instance
        .collection('userlist')
        .where('email', isEqualTo: '$email')
        .getDocuments();
    return snapshot;
  }

  Card News(DocumentSnapshot doc) {
    return Card(
      // child: Text(doc.toString()),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: InkWell(
          child: Column(
            children: <Widget>[
              Image.asset(
                "dfgdf",
                height: 170,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
              FutureBuilder(
                  future:Firestore.instance
                      .collection('userlist')
                      .where('email', isEqualTo: '${doc.data['post_by']}')
                      .getDocuments(),
                  // ignore: missing_return
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      print(snapshot.data.toString());
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage(
                            "Image",
                          ),
                        ),
                        contentPadding: EdgeInsets.all(0),
                        title: Text(
                          "Title",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: Text(
                          "trailing",
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 11,
                          ),
                        ),
                      );
                    } else {
                      Text('Erro while fetvhing user details');
                    }
                  }),
            ],
          ),
          onTap: () {},
        ),
      ),
    );
  }
}
