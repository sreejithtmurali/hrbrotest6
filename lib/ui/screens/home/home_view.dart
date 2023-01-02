import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hrbrotest/models/Products.dart';
import 'package:hrbrotest/ui/screens/Cart/cart_viewmodel.dart';
import 'package:badges/badges.dart';
import 'package:stacked/stacked.dart';
import '../../../services/databasehelper.dart';
import 'home_viewmodel.dart';

class HomeView extends StatelessWidget {

  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return ViewModelBuilder<HomeViewModel>.nonReactive(
      builder: (context, viewModel, child) {
        viewModel.getaddress();
viewModel.getcartcount();


//viewModel.getuserdata();


     return Scaffold(
        appBar: AppBar(
          leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,), onPressed: () { Navigator.pop(context); },),
            backgroundColor: Color(0xff092f92),
          title: Row(
          children: [
            SizedBox(width:15,height:15,child: Center(child: Icon(Icons.location_on_outlined,color: Colors.white))),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text('${viewModel.address}',style: TextStyle(color: Colors.white,fontSize: 16),),
              ),
            ),
          ],
        ),
        actions: [
          GetCount(viewModel:viewModel)
        ],),
        body: SizedBox.expand(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:  [
                Padding(
                  padding: const EdgeInsets.only(left:8,top: 30),
                  child: SizedBox(
                      height:27,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("New Arrivals",style: TextStyle(fontSize: 18,color: Color(0xff092f92),fontWeight:FontWeight.bold ),)

                      ],)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: SizedBox(
                     height: 215,

                      child: FutureBuilder<List<Products>>(

                          future: viewModel.getProducts(),

                          builder:(BuildContext context, AsyncSnapshot snapshot) {

                            if (snapshot.hasData) {
                              var s=snapshot.data as List<Products>;
                              print(s.length.toString());
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: s==null?0:s.length,
                                itemBuilder: (BuildContext context,int index){
                                  Products p=s[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Card(
                                      elevation: 5,
                                      color: Colors.white,
                                      child: SizedBox(
                                        width: 160,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(bottom: 8.0),
                                                  child: SizedBox(
                                                    child: ElevatedButton(

                                                    style: ElevatedButton.styleFrom(
                                                      backgroundColor:Color(0xff092f92) ,

                                                      shape: StadiumBorder(),
                                                    ),
                                                    child: const Text('Add to cart',  style: TextStyle(fontSize: 12,color: Colors.white)),
                                                    onPressed: () {
                                                      print("incremented");
                                                      CartItem c=CartItem(productId:p.productId,productName:p.productName, strapColor: p.strapColor, highlights: p.highlights, price:double.parse(p.price.toString()) , status: p.status.toString(), image: p.image, count: 1);
                                                      viewModel.additem(c);

                                                    },
                                                  ), height: 30,width: 128,),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),

                                      ),
                                    ),
                                  );
                                },

                              );
                            }
                            else if (snapshot.hasError) {
                              return Icon(Icons.error_outline);
                            } else {
                              return CircularProgressIndicator();
                            }
                          }
                      ),

                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left:8,top: 30),
                  child: SizedBox(
                      height:27,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Latest Products",style: TextStyle(fontSize: 18,color: Color(0xff092f92),fontWeight:FontWeight.bold),)

                        ],)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: SizedBox(
                    child: FutureBuilder<List<Product1>>(
                        future: viewModel.getProductsfromdb(),
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
                                          child: Align(alignment:Alignment.topLeft,child: Text(p1.productName,style: TextStyle(fontWeight: FontWeight.bold,color:Color(0xff092f92)),)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0),
                                          child: Align(alignment:Alignment.topLeft,child: Text(' \u{20B9} ${p1.price.toString()}')
                                          ),
                                        ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(bottom: 8.0),
                                                child: SizedBox(
                                                  height: 30,width: 128,
                                                  child: ElevatedButton(

                                                    style: ElevatedButton.styleFrom(
                                                      backgroundColor:Color(0xff092f92) ,

                                                      shape: StadiumBorder(),
                                                    ),
                                                    child: const Text('Add to cart',  style: TextStyle(fontSize: 12,color: Colors.white)),
                                                    onPressed: () {
                                                      CartItem c=CartItem(productId:p1.productId,productName:p1.productName, strapColor: p1.strapColor, highlights: p1.highlights, price:double.parse(p1.price.toString()) , status: p1.status.toString(), image: p1.image, count: 1);
                                                      viewModel.additem(c);
                                                      print("incremented");
                                                    },
                                                  ),),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),

                                    ),

                                );
                              },

                            );
                          }
                          else if (snapshot.hasError) {
                            return Icon(Icons.error_outline);
                          } else {
                            return CircularProgressIndicator();
                          }
                        }
                    ),

                  ),
                ),

              ],
            ),
          ),
        ),

      );

      }, viewModelBuilder: () { return HomeViewModel(); },
    );

  }




}
class GetCount extends StatelessWidget {
  HomeViewModel viewModel;
   GetCount({Key? key,required this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15.0,top: 5),
      child: Badge(
        badgeContent: Text('${viewModel.cartcount}'),
        child: IconButton(icon:Icon(Icons.add_shopping_cart_outlined,color: Colors.white,), onPressed: () {
          viewModel.navigateCart();
        },),
      ),
    );
  }
}





