import 'Products.dart';

class MainResp {
  MainResp({
      required this.status,
      required this.products,
      required this.message,});

  MainResp.fromJson(dynamic json) {
    status = json['status'];
    if (json['Products'] != null) {
      products = [];
      json['Products'].forEach((v) {
        products.add(Products.fromJson(v));
      });
    }
    message = json['message'];
  }
 late bool status;
 late List<Products> products;
 late String message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (products != null) {
      map['Products'] = products.map((v) => v.toJson()).toList();
    }
    map['message'] = message;
    return map;
  }

}