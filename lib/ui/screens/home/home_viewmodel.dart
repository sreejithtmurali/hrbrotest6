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
import '../../../services/user_service.dart';

class HomeViewModel extends BaseViewModel {
  int cartcount = 0;

  void incrementCount() {
    cartcount++;
    notifyListeners();
  }
  void decrementCount() {
    cartcount--;
    notifyListeners();
  }
  final _locationService = locator<LocationService>();
  final _apiService = locator<ApiService>();
  final _dbservice = locator<DBManager>();
  final _userservice = locator<UserService>();
  Future<String?> getuserdata() async{
   return _userservice.user.displayName;
}
  int counter = 0;
  String _address="unable to fetch location data";
  late Future<List<Products>> datalist;
  String get address => _address;
  late Future<LocationData?> _addr;
  late  Future<List<CartItem>>cartitemlist;

  Future<List<CartItem>> getcartProducts() async{
    print("calling fn frm viewmodel service");
    cartitemlist=  _dbservice.getCartList();
    notifyListeners();
    return cartitemlist;

  }

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
    datalist=  _apiService.fetchProducts();
    notifyListeners();
    return datalist;

}

  void additem(CartItem p) {


    _dbservice.insertCart(p).then((value) => navigateCart());

  }
  Future<int> getcartcount() async{
    cartcount=await _dbservice.getCartCount();
    notifyListeners();
    print(cartcount.toString());
    return  cartcount;
  }

  late Future<List<Product1>> datalist1;
  Future<List<Product1>> getProductsfromdb() async{
    print("calling fn frm db service");
    datalist1=  _dbservice.getProducttList();
    print(datalist1.toString());
    notifyListeners();
    return datalist1;

  }

  navigateCart() {
    navigationService.navigateTo(Routes.cartView);
  }
}
