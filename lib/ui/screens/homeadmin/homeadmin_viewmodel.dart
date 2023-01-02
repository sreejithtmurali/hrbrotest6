import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:hrbrotest/models/MainResp.dart';
import 'package:hrbrotest/services/location_service.dart';
import 'package:location/location.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../app/utils.dart';
import '../../../models/Products.dart';
import '../../../services/api_service.dart';
import '../../../services/databasehelper.dart';

class HomeAdminViewModel extends BaseViewModel {
  final _locationService = locator<LocationService>();
  final _apiService = locator<ApiService>();
  final _dbservice = locator<DBManager>();

  int counter = 0;
  String _address="Kochi";
  late Future<List<Products>> _datalist;

  Future<List<Products>> get datalist => _datalist;
  late Future<List<Product1>> _datalist1;
  Future<List<Product1>> getProductsfromdb() async{
    print("calling fn frm db service");
    _datalist1=  _dbservice.getProducttList();
    notifyListeners();
    print(datalist1.toString());
    notifyListeners();
    return datalist1;

  }
  void updateitem(Product1 p) {


    _dbservice.updateProduct(p).then((value) => navigateself());
    _datalist1= getProductsfromdb();
    notifyListeners();

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
  void delete(int id){
    _dbservice.deleteProduct(id);
    notifyListeners();

  }

  String get address => _address;
  late Future<LocationData?> _addr;


  Future<void> getaddress() async {
    _addr=_locationService.getLocation();
    LocationData? loc=await _addr;
    List<Placemark> placemarks = await placemarkFromCoordinates(loc!.latitude!.toDouble(), loc!.longitude!.toDouble());
    Placemark place = placemarks[0];
    _address =  '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    print(_address);
    notifyListeners();
  }
  void updateTitle() {
    counter++;
    notifyListeners();
  }
Future<List<Products>> getProducts() async{
  print("calling fn frm viewmodel service");
    _datalist=  _apiService.fetchProducts();
    notifyListeners();
    return datalist;

}
  void navigateAdd() {
    navigationService.navigateTo(Routes.addView);
  }
  void navigateself() {
    navigationService.navigateTo(Routes.homeAdminView);
  }

  Future<List<Product1>> get datalist1 => _datalist1;
}
