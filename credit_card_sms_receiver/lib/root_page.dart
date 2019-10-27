import 'package:credit_card_sms_receiver/sign_in.dart';
import 'package:credit_card_sms_receiver/sms_input_page.dart';
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
          userStatus = snapshot.data;
          return SmsInputPage("");
        }
        else {
          return SignIn();
        }
      },
    );
  }
}