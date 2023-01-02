import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrbrotest/models/Products.dart';
import 'package:hrbrotest/ui/screens/Cart/cart_viewmodel.dart';
import 'package:badges/badges.dart';
import 'package:stacked/stacked.dart';
import '../../../services/databasehelper.dart';
import 'homeadmin_viewmodel.dart';

class HomeAdminView extends StatelessWidget {
  const HomeAdminView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeAdminViewModel>.nonReactive(
      builder: (context, viewModel, child) {
        viewModel.getProductsfromdb();


        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: Color(0xff092f92),
            title: Text(
              'Products',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          body: SizedBox.expand(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8, top: 30),
                    child: SizedBox(
                        height: 27,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Json Products",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xff092f92),
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: SizedBox(
                      height: 205,
                      child: FutureBuilder<List<Products>>(
                          future: viewModel.getProducts(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              var s = snapshot.data as List<Products>;
                              print(s.length.toString());
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: s == null ? 0 : s.length,
                                itemBuilder: (BuildContext context, int index) {
                                  Products p = s[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Card(
                                      elevation: 5,
                                      color: Colors.white,
                                      child: SizedBox(
                                        width: 160,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            ClipRRect(
                                              borderRadius: BorderRadius.circular(10),
                                              child: Image.network(
                                                p.image,
                                                width: 180,
                                                height: 120,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 8.0),
                                              child: Align(alignment:Alignment.topLeft,child: Text(p.productName,style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xff092f92)),)),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 8.0),
                                              child: Align(alignment:Alignment.topLeft,child: Text(' \u{20B9} ${p.price.toString()}')
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            } else if (snapshot.hasError) {
                              return Icon(Icons.error_outline);
                            } else {
                              return CircularProgressIndicator();
                            }
                          }),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, top: 30),
                    child: SizedBox(
                        height: 27,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Database Products",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xff092f92),
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        )),
                  ),
                  SizedBox(

                    child:getData(viewModel: viewModel)
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            foregroundColor: Color(0xff092f92),
            onPressed: () {
              viewModel.navigateAdd();
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        );
      },
      viewModelBuilder: () {
        return HomeAdminViewModel();
      },
    );
  }

 Widget getData({required HomeAdminViewModel viewModel}) {
    return Dbdata(viewModel: viewModel,);
 }

}
Future<void> _displayTextInputDialog(BuildContext context, Product1 p1, HomeAdminViewModel viewModel,) async {
  var nameController1 = TextEditingController();
  var strapController1 = TextEditingController();
  var highlightController1 = TextEditingController();
  var priceController1 = TextEditingController();
  var statusController1 = TextEditingController();
  var imageController1= TextEditingController();
  nameController1.text=p1.productName;
  strapController1.text=p1.strapColor;
  highlightController1.text=p1.highlights;
  priceController1.text=p1.price.toString();
  statusController1.text=p1.status;
  imageController1.text=p1.image;
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit'),
          content: SingleChildScrollView(
            child: Column(children: [
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: nameController1,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Prouct Name',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextField(

                  controller: strapController1,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Strap Color',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextField(

                  controller: highlightController1,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Highlights',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextField(
                  controller: priceController1,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Price',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextField(

                  controller: statusController1,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Status',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextField(

                  controller: imageController1,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Image Url',
                  ),
                ),
              ),
            ],),
          ),
          actions: <Widget>[
            ElevatedButton(

              child: Text('Update'),
              onPressed: () {bool b;
              if( statusController1.text.toLowerCase() =='true'){
                b=true;
              }
              else{
                b=false;
              }

              Product1 p=Product1(productId:p1.productId,productName: nameController1.text, strapColor: strapController1.text, highlights: highlightController1.text, price: double.parse(priceController1.text.toString()), status: b.toString(), image: imageController1.text);
              viewModel.updateitem(p);
              Navigator.pop(context);
              },
            ),

          ],
        );
      });
}

class Dbdata extends StatefulWidget {
  HomeAdminViewModel viewModel;
  Dbdata({Key? key,required this.viewModel}) : super(key: key);

  @override
  State<Dbdata> createState() => _DbdataState();
}

class _DbdataState extends State<Dbdata> {
  late Future<List<Product1>> f;
  @override
  void initState() {
    // TODO: implement initState

    f=getData();

  }
  Future<List<Product1>> getData() {
    setState(() {
      f=widget.viewModel.getProductsfromdb();
    });
    return widget.viewModel.getProductsfromdb();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product1>>(
        future: f,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            var s1 = snapshot.data as List<Product1>;
            print("data");
            return GridView.builder(
              physics: const BouncingScrollPhysics(),
              gridDelegate:
              const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 300,
                  mainAxisExtent:210 ,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 15),
              shrinkWrap: true,
              itemCount: s1.length ==0?0:s1.length,
              itemBuilder: (BuildContext context, int index) {
                var p1 = s1[index];
                print(p1.strapColor);
                return Card(
                  elevation: 5,
                  color: Colors.white,
                  child: SizedBox(
                    width: 185,

                    child: Column(
                      mainAxisAlignment:
                      MainAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            p1.image,
                            width: 180,
                            height: 110,
                            fit: BoxFit.cover,
                          ),
                        )
                        ,

                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Align(alignment:Alignment.topLeft,child: Text(p1.productName,style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xff092f92)),)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Align(alignment:Alignment.topLeft,child: Text(' \u{20B9} ${p1.price.toString()}')
                          ),
                        ),
                        SizedBox(
                          height: 35,
                          child: Stack(children: [
                            Positioned(
                                left:10.0,
                                child: IconButton(onPressed: () {
                                  _displayTextInputDialog(context,p1,widget.viewModel).then((value) => getData());
                                  getData();
                                 
                                }, icon: Icon(Icons.edit,color: Colors.green,),)
                            ),
                            Positioned(
                                right:10.0,
                                child: IconButton(onPressed: () {
                                  s1.removeWhere((item) => item.productId == p1.productId);
                                  widget.viewModel.delete(int.parse(p1.productId.toString()));
                                
                                 getData();
                                }, icon: Icon(Icons.delete,color: Colors.red),)),
                          ],),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            print(snapshot.error.toString());
            return Icon(Icons.error_outline);
          } else {
            return CircularProgressIndicator();
          }
        });
  }


}


