import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/search_page.dart';
import 'home_page.dart';
import 'account_page.dart';

class TabPage extends StatefulWidget {
  final FirebaseUser user;

  TabPage(this.user);

  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  int _selectedIndex = 0;
  List _pages;

  @override
  void initState() {
    super.initState();

    this._pages = [
      HomePage(widget.user),
      SearchPage(widget.user),
      AccountPage(widget.user)
    ];
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _pages[_selectedIndex],),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.black,
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        items:<BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title:Text('Home')),
          BottomNavigationBarItem(icon: Icon(Icons.search), title:Text('Search')),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), title:Text('Account')),
        ]
      ),
    );
  }
          
  void _onItemTapped(int value) {
    setState(() {
      _selectedIndex = value;
    });
  }
}