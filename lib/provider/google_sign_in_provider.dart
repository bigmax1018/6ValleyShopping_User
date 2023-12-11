import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider with ChangeNotifier {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? googleAccount;
  late GoogleSignInAuthentication auth;

  Future<void> login() async {
    googleAccount = await _googleSignIn.signIn();
    auth = await googleAccount!.authentication;
    notifyListeners();
  }
}
