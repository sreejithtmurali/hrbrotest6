import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../constants/assets.gen.dart';
import '../../../models/Products.dart';
import '../../../services/databasehelper.dart';
import '../home/home_viewmodel.dart';
import 'cart_viewmodel.dart';

class CartView extends StatelessWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CartViewViewModel>.nonReactive(
      builder: (context, viewModel, child) {
        viewModel.getaddress();
        viewModel.getcartcount();
        int count = 1;

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
            title: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text(
                      'My Cart',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
            actions: [GetCount(viewModel: viewModel)],
          ),
          body: SizedBox.expand(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8, top: 10),
                    child: SizedBox(
                        height: 27,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Text(
                              " My Cart Items",
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
                      height: 215,
                      child: FutureBuilder<List<CartItem>>(
                          future: viewModel.getcartProducts(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              var s = snapshot.data as List<CartItem>;
                              print(s.length.toString());
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: s == null ? 0 : s.length,
                                itemBuilder: (BuildContext context, int index) {
                                  CartItem p = s[index];
                                  count = p.count;
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
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.network(
                                                p.image,
                                                width: 180,
                                                height: 120,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                    p.productName,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            Color(0xff092f92)),
                                                  )),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                      ' \u{20B9} ${p.price.toString()}')),
                                            ),
                                            CounterWidget(
                                                viewModel: viewModel,
                                                p: p,
                                                count2: count)
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
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, top: 30),
                    child: SizedBox(
                        height: 1,
                      child: Container(
                        color:Color(0xff092f92),

                      ),
                  ),),
                  SizedBox(
                    height: MediaQuery.of(context).size.height/4,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text("Total items :"),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            viewModel.cartcount.toString(),
                            style: TextStyle(
                                color: Color(0xff092f92),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text("Total Price :"),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Text(" \u{20B9} 55000",style: TextStyle(
                              color: Color(0xff092f92),
                              fontWeight: FontWeight.bold),),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text("Delivery Charge:"),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Text(" \u{20B9} 50",style: TextStyle(
                              color: Color(0xff092f92),
                              fontWeight: FontWeight.bold),),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text("Net Amount:"),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Text(" \u{20B9} 55050",style: TextStyle(
                              color: Color(0xff092f92),
                              fontWeight: FontWeight.bold),),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                 CheckoutWidget()
                ],
              ),
            ),
          ),
        );
      },
      viewModelBuilder: () {
        return CartViewViewModel();
      },
    );
  }
}
class CheckoutWidget extends StatefulWidget {

   CheckoutWidget({Key? key}) : super(key: key);
  

  @override
  State<CheckoutWidget> createState() => _CheckoutWidgetState();
}

class _CheckoutWidgetState extends State<CheckoutWidget> {
  late Razorpay _razorpay;
  String PAYMENT_STATUS="";

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void createOrder() async
  {
    var options = {
      'key': 'rzp_test_PNY7cIcQ0NlTaN',
      'amount': 55050*100,
      'name': 'Sreejith Murali',
      'description': 'MyWatch',
      'prefill': {'contact': '8111821149', 'email': 'sreejithtmurli@gmail.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width - 100,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xff092f92),
              shape: StadiumBorder(),
            ),
            child: const Padding(
              padding:
              EdgeInsets.only(left: 8.0, right: 8.0),
              child: Text('Checkout',
                  style: TextStyle(
                      fontSize: 16, color: Colors.white)),
            ),
            onPressed: () {
              createOrder();


            },
          ),
        ),
      ],
    );
  }
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print("Payment Process On response success ${response.paymentId}");
    setState(() {
      PAYMENT_STATUS="Payment Success.\n\nYour Payment Id is: ${response.paymentId}";
    });
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("Payment Process On response Error ${response.message}");
    setState(() {
      PAYMENT_STATUS="Payment Failed.  ${response.message}";
    });
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("Payment Process On response Waller ${response.walletName}");
    setState(() {
      PAYMENT_STATUS="Payment Done with wallet information .  ${response.walletName}";
    });
  }

}





class CounterWidget extends StatefulWidget {
  late CartViewViewModel viewModel;
  late CartItem p;
  late int count2;
  CounterWidget({
    Key? key,
    required this.viewModel,
    required this.p,
    required this.count2,
  }) : super(key: key);

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: SizedBox(
            height: 30,
            width: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff092f92),
                shape: StadiumBorder(),
              ),
              child: Center(
                  child: const Text('+',
                      style: TextStyle(fontSize: 12, color: Colors.white))),
              onPressed: () {
                setState(() {
                  widget.count2++;
                });

                print("incremented");
                CartItem c = CartItem(
                    productId: widget.p.productId,
                    productName: widget.p.productName,
                    strapColor: widget.p.strapColor,
                    highlights: widget.p.highlights,
                    price: double.parse(widget.p.price.toString()),
                    status: widget.p.status.toString(),
                    image: widget.p.image,
                    count: widget.p.count++);
                widget.viewModel.UpdateCartProducts(c);
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: SizedBox(
            height: 30,
            width: 30,
            child: Center(child: Text('${widget.count2.toString()}')),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: SizedBox(
            height: 30,
            width: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff092f92),
                shape: StadiumBorder(),
              ),
              child: const Text('-',
                  style: TextStyle(fontSize: 12, color: Colors.white)),
              onPressed: () {
                setState(() {
                  widget.count2--;
                });

                print("decremented");
                CartItem c = CartItem(
                    productId: widget.p.productId,
                    productName: widget.p.productName,
                    strapColor: widget.p.strapColor,
                    highlights: widget.p.highlights,
                    price: double.parse(widget.p.price.toString()),
                    status: widget.p.status.toString(),
                    image: widget.p.image,
                    count: widget.p.count--);
                widget.viewModel.UpdateCartProducts(c);
              },
            ),
          ),
        ),
      ],
    );
  }
}

class GetCount extends StatelessWidget {
  CartViewViewModel viewModel;
  GetCount({Key? key, required this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int c=viewModel.cartcount;
    return Padding(
      padding: const EdgeInsets.only(right: 15.0, top: 5),
      child: Badge(
        badgeContent: Text('${c}'),
        child: IconButton(
          icon: Icon(
            Icons.add_shopping_cart_outlined,
            color: Colors.white,
          ),
          onPressed: () {
            viewModel.navigateCart();
          },
        ),
      ),
    );
  }
}
