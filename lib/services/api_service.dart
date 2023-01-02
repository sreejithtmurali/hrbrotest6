import 'dart:convert';
import '../../../generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:hrbrotest/services/user_service.dart';
import 'package:http/retry.dart';
import 'package:http/http.dart' as http;

import '../app/app.locator.dart';
import '../constants/app_strings.dart';
import '../models/MainResp.dart';
import '../models/Products.dart';
import '../models/basics.dart';

class ApiService {
  static const environment = ApiEnvironment.dev;

  static String baseUrl = environment.baseUrl;
  static String baseUrlApi = "$baseUrl/public/api";
  static String baseUrlImage = "$baseUrl/public/storage";
  Future<List<Products>> fetchProducts() async {
    print("calling fn frm api service");
    List<Products> list=[];
    final response =
    await rootBundle.loadString(Assets.jsonPopularlist);

    var getDetailData = MainResp.fromJson(json.decode(response));
    list=getDetailData.products;
    print(getDetailData.products[0].productName.toString());
    return list;

    //throw Exception('Failed to load Users');
  }
   final _userService = locator<UserService>();
  // final _notificationService = locator<NotificationService>();

  var client = RetryClient(
    http.Client(),
    whenError: (onError, stackTrace) {
      if (onError.toString().contains(AppStrings.connectionClosedError)) {
        debugPrint("Retring....");
        return true;
      }
      return false;
    },
  );
  Duration timeoutDuration = const Duration(seconds: 20);
  Map<String, String> get userHeader {
    // if (user?.accessToken != null) {
    //   return {
    //     'Accept': 'application/json',
    //     'Authorization': 'Bearer ${user!.accessToken}',
    //     'Content-Type': 'application/json',
    //   };
    // }
    debugPrint('Token is null');
    return jsonHeader;
  }

  static const Map<String, String> jsonHeader = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };

  // Future<void> saveLoginCredential(AppUser appUser) async {
  // user = appUser;
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // prefs.setBool(Prefs.isLoggedIn, true);
  // prefs.setString(Prefs.user, jsonEncode(user!.toJson()));
  // }

  // Future<AppUser?> loadCredential() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? value = prefs.getString(Prefs.user);
  //   if (value != null) {
  //     user = AppUser.fromJson(jsonDecode(value));
  //   } else {
  //     user = null;
  //   }
  //   return user;
  // }
  Future<bool> handleLogin({
    required String mobile,
    required String countryCode,
  }) async {
    bool status = false;
    debugPrint(mobile);
    debugPrint(countryCode);
    debugPrint("$baseUrlApi/login");
    var response = await client
        .post(
      Uri.parse("$baseUrlApi/login"),
      headers: jsonHeader,
      body: jsonEncode({
        "phone_no": mobile,
        "country_code": countryCode,
      }),
    )
        .timeout(
      timeoutDuration,
      onTimeout: () => http.Response("Request Timeout", 408),
    )
        .catchError((onError) => http.Response("$onError", 404));

    if (response.statusCode == 200) {
      BasicResponse responseBody = BasicResponse.fromJson(
        jsonDecode(response.body),
      );
      debugPrint("${responseBody.errorcode}");
      if (responseBody.errorcode == 0) {
        debugPrint(
          'login Response: Success -> ${responseBody.message}',
        );
        status = true;
      //  _userService.setTempUser(responseBody.data);
        //  SmartDialog.showToast("${_userService.tempUser?.otp}");
      } else if (responseBody.errorcode == 2) {
        status = false;
        debugPrint(
          'login Response: contact admin -> ${responseBody.data}',
        );
        SmartDialog.showToast("${responseBody.message}");
      } else if (responseBody.errorcode == 3) {
        status = false;
        debugPrint(
          'login Response: contact admin -> ${responseBody.data}',
        );
        SmartDialog.showToast("${responseBody.message}");
      } else {
        debugPrint('login Response: Error -> ${responseBody.message}');
      }
    } else {
      debugPrint('login Response: Server Error -> ${response.body}');
    }
    return status;
  }
}

enum ApiEnvironment {
  dev("https://example.com"),
  prod("https://prod.example.com");

  const ApiEnvironment(this.baseUrl);

  final String baseUrl;
}
