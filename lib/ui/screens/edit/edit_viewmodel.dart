import 'package:flutter/cupertino.dart';
import 'package:hrbrotest/services/databasehelper.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../app/utils.dart';
import '../../../services/api_service.dart';

class EditViewModel extends BaseViewModel {
  String ? Username;
  String ?password;
 final _dbservice = locator<DBManager>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  void additem(Product1 p) {


    _dbservice.insertStudent(p).then((value) => navigateAdminHome());


    // Username=user;
    // password=pass;
    // notifyListeners();
    // if(user=="admin"){
    //   if(password=="12345678"){
    //     navigateAdminHome();
    //   }
    // }
    // else{
    //   navigate();
    // }



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
}


