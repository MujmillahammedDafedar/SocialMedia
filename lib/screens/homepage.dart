import 'package:flutter/material.dart';
import 'package:mychat/model/Auth.dart';
import 'news_screen.dart';
import 'trending.dart';
import 'my_profile.dart';
class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _selectedIndex = 0;
  GlobalKey navBarGlobalKey = GlobalKey(debugLabel: 'bottomAppBar');
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static  List<Widget> _widgetOptions = <Widget>[
    NewsFeed(),
    Trending(),
    Profile()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:new AppBar(
        backgroundColor: Colors.teal,
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: <Widget>[
          // action button
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              //
            },
          ),
          // action button
        ],
        title: new Text('Homepage'
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          // sets the background color of the `BottomNavigationBar`
            canvasColor: Colors.green,
            // sets the active color of the `BottomNavigationBar` if `Brightness` is light
            primaryColor: Colors.red,
            textTheme: Theme
                .of(context)
                .textTheme
                .copyWith(caption: new TextStyle(color: Colors.deepOrangeAccent))),

        child: BottomNavigationBar(
          key: navBarGlobalKey,
          type: BottomNavigationBarType.fixed ,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('News feed'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.whatshot),
              title: Text('Trending'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle,),
              title: Text('My profile'),

            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.teal,
          backgroundColor: Colors.teal.shade50,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
