import 'package:credit_card_sms_receiver/history_page.dart';
import 'package:credit_card_sms_receiver/sign_in.dart';
import 'package:credit_card_sms_receiver/user_status.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FirebaseUser> (
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        print(snapshot.hasData);
        if(snapshot.hasData) {
          print("Go to the HistoryPage");
          userStatus = snapshot.data;
          return HitoryPage();
        }
        else {
          print("Go to the SignInPage");
          return SignIn();
        }
      },
    );
  }
}