// import 'dart:convert';

// import 'package:shared_preferences/shared_preferences.dart';

// import '../constants/app_constants.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserService {
  final googleSigIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;
  Future googleLogin() async{
    try
    {
      final googleUser = await googleSigIn.signIn();
      if (googleUser == null) return;
      _user = googleUser;
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      await FirebaseAuth.instance.signInWithCredential(credential);
    }
    catch(e){
      print(e.toString());
    }

  }
  Future logout() async{
    await googleSigIn.disconnect();
    FirebaseAuth.instance.signOut();
  }
}
