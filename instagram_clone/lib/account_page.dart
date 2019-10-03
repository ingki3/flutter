import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AccountPage extends StatefulWidget {
  final FirebaseUser user;

  AccountPage(this.user);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  int _postCount = 0;

  @override
  void initState() {
    super.initState();
    Firestore.instance.collection('post').where('email', isEqualTo: widget.user.email)
    .getDocuments().then((snapshot) {
      setState(() {
        _postCount = snapshot.documents.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
          );
        }
      
  Widget _buildAppBar() {
    return AppBar(
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.exit_to_app),
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
            await _googleSignIn.signOut();
          },
        )
      ],
    );
  }
      
  Widget  _buildBody() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  SizedBox(
                    height: 80,
                    width: 80,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(widget.user.photoUrl),
                    ),
                  ),
                  Container(
                    width: 80.0,
                    height: 80.0,
                    alignment: Alignment.bottomRight,
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 28.0,
                          width: 28.0,
                          child: FloatingActionButton(
                            onPressed: (){},
                            backgroundColor: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 25.0,
                          width: 25.0,
                          child: FloatingActionButton(
                            onPressed: (){},
                            backgroundColor: Colors.blue,
                            child: Icon(Icons.add),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding( padding: EdgeInsets.all(8.0),
              ),
              Text('Name', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
            ],
          ),
          Text('$_postCount\n게시물',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18.0),
          ),
          Text('0\n팔로워',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18.0),
          ),
          Text('0\n팔로잉',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18.0),
          ),
        ]
      ,),
    );
  }
}