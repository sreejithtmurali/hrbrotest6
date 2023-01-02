import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

import 'app.locator.dart';

String getDeviceType() {
  String deviceType = '';
  if (Platform.isAndroid) {
    deviceType = '1';
  } else if (Platform.isIOS) {
    deviceType = '2';
  }
  return deviceType;
}

NavigationService get navigationService => locator<NavigationService>();
DialogService get dialogService => locator<DialogService>();
BottomSheetService get sheetService => locator<BottomSheetService>();

void dismissKeyboard(BuildContext context) {
  FocusScopeNode currentFocus = FocusScope.of(context);

  if (!currentFocus.hasPrimaryFocus) {
    currentFocus.unfocus();
  }
}

String removeZero(double? value) {
  if (value == null) return "0";
  RegExp regex = RegExp(r"([.]*0)(?!.*\d)");
  return value.toString().replaceAll(regex, "");
}

String getRandomString(int length) {
  const chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random rnd = Random();

  return String.fromCharCodes(
    Iterable.generate(
      length,
      (_) => chars.codeUnitAt(rnd.nextInt(chars.length)),
    ),
  );
}

String secToTime(int sec) {
  String time = Duration(seconds: sec).toString();
  return time.substring(time.indexOf(':') + 1, time.lastIndexOf('.'));
}

bool isAdult(DateTime dob) {
  DateTime adultDate = DateTime(dob.year + 21, dob.month, dob.day);
  return adultDate.isBefore(DateTime.now());
}

String listToString(List<String?> list) {
  String s = "";
  for (var i = 0; i < list.length; i++) {
    if (list[i] != null) {
      if (i < list.length - 1) {
        s += '${list[i]!}, ';
      } else {
        s += list[i]!;
      }
    }
  }
  return s;
}
