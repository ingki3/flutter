import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreatePage extends StatefulWidget {
  final FirebaseUser user;

  CreatePage(this.user);
  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final textEditingController = TextEditingController();

  File _image;

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _getImage();
        },
        child: Icon(Icons.add_a_photo),
      ),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      actions: <Widget>[
        IconButton(
          onPressed: () {
            final firebaseStoregeRef = FirebaseStorage.instance.ref().child('post').child('${DateTime.now().millisecondsSinceEpoch}.png');
            final task = firebaseStoregeRef.putFile(
              _image, StorageMetadata(contentType:'image/png')
            );
            task.onComplete.then((value){
              var downloadUrl = value.ref.getDownloadURL();
              downloadUrl.then((uri){
                var doc = Firestore.instance.collection('post').document();
                doc.setData({
                  'id':doc.documentID,
                  'photoUrl':uri.toString(),
                  'contents': textEditingController.text,
                  'email': widget.user.email,
                  'displayName': widget.user.displayName,
                  'userPhotoUrl': widget.user.photoUrl
                }).then((onValue) {
                  Navigator.pop(context);
                });
              });
            });
          },
          icon: Icon(Icons.send),
        ),
      ],
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
          child: Column(
        children: <Widget>[
          _image == null ? Text('no Image') : Image.file(_image),
//          Text('no Image'),
          TextField(
            controller: textEditingController,
            decoration: InputDecoration(hintText: '내용을 입력하세요.'),
          )
        ],
      ),
    );
  }

  Future _getImage() async{
    File image = await ImagePicker.pickImage(source: ImageSource.camera);
    print(image.path);
    setState(() {
        _image = image;
      }
    );
  }      

}
