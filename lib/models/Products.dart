class Products {
  Products({
      required this.productId,
      required this.productName,
      required this.strapColor,
      required this.highlights,
      required this.price,
      required this.status,
      required this.image,});

  Products.fromJson(dynamic json) {
    productId = json['ProductId'];
    productName = json['ProductName'];
    strapColor = json['StrapColor'];
    highlights = json['highlights'];
    price = json['Price'];
    status = json['Status'];
    image = json['image'];
  }
  late int productId;
  late String productName;
  late String strapColor;
  late String highlights;
  late int price;
  late bool status;
  late  String image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ProductId'] = productId;
    map['ProductName'] = productName;
    map['StrapColor'] = strapColor;
    map['highlights'] = highlights;
    map['Price'] = price;
    map['Status'] = status;
    map['image'] = image;
    return map;
  }

}