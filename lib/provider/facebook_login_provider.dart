import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FacebookLoginProvider with ChangeNotifier {
  Map? userData;
  late LoginResult result;

  Future<void> login() async {
    result = await FacebookAuth.instance.login();
    if (result.status == LoginStatus.success) {
      userData = await FacebookAuth.instance.getUserData();

    }
    notifyListeners();
  }

}
