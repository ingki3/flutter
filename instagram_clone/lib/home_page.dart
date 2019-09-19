import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Instagram Clone',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ), 
      body: _buildBody(),   
    );        
  }
        
  Widget  _buildBody() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                Text('Instagram에 오신 것을 환영합니다.', style: TextStyle(fontSize: 24.0),
                ),
                Padding(padding: EdgeInsets.all(8.0),
                ),
                Text('사진과 동영상을 보려면 팔로우 하세요',
                ),
                SizedBox(
                  width: 260.0,
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          width: 80.0,
                          height: 80.0,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage('http://talkimg.imbc.com/TVianUpload/tvian/TViews/image/2018/02/02/Y8qABqMeFbhH636531733604162498.jpg'),
                          ),
                        ),
                        Padding(padding: EdgeInsets.all(8.0),
                        ),
                        Text('Email address', style:TextStyle(fontWeight: FontWeight.bold)),
                        Text('Name'),
                        Padding(padding: EdgeInsets.all(8.0),
                        ),
                        RaisedButton(
                          child: Text('Follow'),
                          color: Colors.blueAccent,
                          textColor: Colors.white,
                          onPressed: () {
                            
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}