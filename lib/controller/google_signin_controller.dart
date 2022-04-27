import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInController with ChangeNotifier {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? googleSignInAccount;

  //function for login
  Future loginG() async {
    googleSignInAccount = await _googleSignIn.signIn();

    //call
    notifyListeners();
  }

  Future logoutG() async {
    this.googleSignInAccount = await _googleSignIn.signOut();

    notifyListeners();
  }
}
