import 'dart:convert';

import '../constants/app_constants.dart';

class BasicResponse {
  int? errorcode;
  Map<String, dynamic>? data;
  List<Map<String, dynamic>>? listData;
  String? message;

  BasicResponse({
    this.errorcode,
    this.data,
    this.listData,
    this.message,
  });

  BasicResponse.fromJson(Map<String, dynamic> json) {
    errorcode = json['errorcode'];
    data = json['data'];
    message = json['message'] is String
        ? json['message']
        : jsonEncode(json['message']);
  }

  BasicResponse.fromJsonList(Map<String, dynamic> json) {
    errorcode = json['errorcode'];
    listData = json['data']?.cast<Map<String, dynamic>>();
    message = json['message'] is String
        ? json['message']
        : jsonEncode(json['message']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> mapData = <String, dynamic>{};
    mapData['errorcode'] = errorcode;
    mapData['data'] = data ?? listData ?? {};
    mapData['message'] = message;
    return mapData;
  }
}

class ToastModel {
  late String message;
  late ToastType type;

  ToastModel({
    required this.message,
    required this.type,
  });

  ToastModel.fromBasicResponse(BasicResponse response) {
    message = response.message ?? "";
    type = ToastType.fromValue(response.errorcode);
  }

  ToastModel.fromJson(Map<String, dynamic> json) {
    message = json['message'] ?? "";
    type = ToastType.fromValue(json[type]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['type'] = type.value;
    return data;
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }

  ToastModel.fromString(String data) {
    var toast = ToastModel.fromJson(jsonDecode(data));
    message = toast.message;
    type = toast.type;
  }
}
