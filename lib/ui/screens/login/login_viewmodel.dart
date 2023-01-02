import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hrbrotest/services/user_service.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../app/utils.dart';
import '../../../services/api_service.dart';

class LoginViewModel extends BaseViewModel {
  String ? Username;
  String ?password;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  final _userservice = locator<UserService>();
  void submitLogin(String user, String pass) {
    Username=user;
    password=pass;
    notifyListeners();
    if(user=="admin"){
      if(password=="12345678"){
        navigateAdminHome();
      }
    }
    else{
      navigate();
    }



  }



  void setAutovalidateMode(AutovalidateMode mode) {
    autovalidateMode = mode;
    notifyListeners();
  }
  void navigate() {
    navigationService.navigateTo(Routes.homeView);
  }
  void navigateAdminHome() {
    navigationService.navigateTo(Routes.homeAdminView);
  }



  Future googleLogin() async{

   _userservice.googleLogin().then((value) =>  navigate());


  }
  Future logout() async{
    _userservice.logout();
    FirebaseAuth.instance.signOut();
  }
}


