import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBManager {
  late Database _datebase;

  Future openDB() async {
    _datebase = await openDatabase(join(await getDatabasesPath(), "products.db"),
        version: 1, onCreate: (Database db, int version) async {
          await db.execute("CREATE TABLE products(productId INTEGER PRIMARY KEY AUTOINCREMENT,productName TEXT,strapColor TEXT,highlights TEXT,price DOUBLE,status Text,image TEXT)");
          await db.execute("CREATE TABLE Mycart(productId INTEGER PRIMARY KEY AUTOINCREMENT,productName TEXT,strapColor TEXT,highlights TEXT,price DOUBLE,status Text,image TEXT,count INTEGER)");
        });

  }



  Future<int> insertStudent(Product1 product1) async {
    await openDB();
    return await _datebase.insert('products', product1.toMap());

  }
  Future<int> insertCart(CartItem product1) async {
    await openDB();
    return await _datebase.insert('Mycart', product1.toMap());

  }
  Future<int> getCartCount() async{
    await openDB();
    final List<Map<String, dynamic>> maps = await _datebase.query('Mycart');
    return maps.length;

  }

  Future<List<CartItem>> getCartList() async {
    await openDB();
    final List<Map<String, dynamic>> maps = await _datebase.query('Mycart');
    return List.generate(maps.length, (index) {
      return CartItem(productId: maps[index]['productId'],
          productName: maps[index]['productName'],
          strapColor: maps[index]['strapColor'],
          highlights: maps[index]['highlights'],
          price: maps[index]['price'],
          status: maps[index]['status'],
          image: maps[index]['image'],
          count: maps[index]['count']
      );
    });
  }



  Future<List<Product1>> getProducttList() async {
    await openDB();
    final List<Map<String, dynamic>> maps = await _datebase.query('products');
    return List.generate(maps.length, (index) {
      return Product1(productId: maps[index]['productId'],
          productName: maps[index]['productName'],
          strapColor: maps[index]['strapColor'],
          highlights: maps[index]['highlights'],
          price: maps[index]['price'],
          status: maps[index]['status'],
          image: maps[index]['image']
      );
    });
  }
  Future<int> updateProduct(Product1 p) async {
    await openDB();
    return await _datebase.update('products', p.toMap(), where: 'productId=?', whereArgs: [p.productId]);
  }

  Future<int> updateCart(CartItem p) async {
    await openDB();
    return await _datebase.update('Mycart', p.toMap(), where: 'productId=?', whereArgs: [p.productId]);
  }
  Future<void> deleteProductFromCart(int? productId) async {
    await openDB();
    await _datebase.delete("Mycart", where: "productId = ? ", whereArgs: [productId]);
  }
  Future<void> deleteProduct(int? productId) async {
    await openDB();
    await _datebase.delete("products", where: "productId = ? ", whereArgs: [productId]);
  }
}


class Product1 {
  Product1({
  this.productId,
    required this.productName,
    required this.strapColor,
    required this.highlights,
    required this.price,
    required this.status,
    required this.image,});
   int? productId;
  late String productName;
  late String strapColor;
  late String highlights;
  late double price;
  late String status;
  late String image;

  Map<String, dynamic> toMap() {
    return { 'productName': productName
      , 'strapColor': strapColor, 'highlights': highlights,
    'price': price, 'status': status,'image':image};
  }}
class CartItem {
  CartItem({
    this.productId,
    required this.productName,
    required this.strapColor,
    required this.highlights,
    required this.price,
    required this.status,
    required this.image,
    required this.count,});
  int? productId;
  late String productName;
  late String strapColor;
  late String highlights;
  late double price;
  late String status;
  late String image;
  late int count;

  Map<String, dynamic> toMap() {
    return { 'productName': productName
      , 'strapColor': strapColor, 'highlights': highlights,
      'price': price, 'status': status,'image':image,'count':count};
  }}