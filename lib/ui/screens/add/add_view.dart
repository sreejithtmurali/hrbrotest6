import 'package:flutter/material.dart';
import 'package:hrbrotest/app/utils.dart';
import 'package:hrbrotest/services/databasehelper.dart';

import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../../constants/assets.gen.dart';
import 'add_viewmodel.dart';

class AddView extends StatelessWidget {
  const AddView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddViewModel>.nonReactive(
      builder: (context, viewModel, child) =>
          Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xff092f92),
              title: Text(
                'Add item',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
        body:  Center(child: _UserLoginForm()),

        // floatingActionButton: FloatingActionButton(
        //   onPressed: () => viewModel.updateTitle(),
        // ),
      ),
      viewModelBuilder: () => AddViewModel(),
    );
  }
}

class _UserLoginForm extends HookViewModelWidget<AddViewModel> {
  @override
  Widget buildViewModelWidget(BuildContext context, AddViewModel model) {
    var nameController = useTextEditingController();
    var strapController = useTextEditingController();
    var highlightController = useTextEditingController();
    var priceController = useTextEditingController();
    var statusController = useTextEditingController();
    var imageController = useTextEditingController();
    final _formKey = GlobalKey<FormState>();
    return Form(
      key: _formKey,
        child:
        Center(
          child: ListView(
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    '',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                        fontSize: 30),
                  )),
              Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Add Item',
                    style: TextStyle(fontSize: 16,color:Color(0xff092f92)),
                  )),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'this field is required';
                    }
                    return null;
                  },
                  controller: nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Prouct Name',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'this field is required';
                    }
                    return null;
                  },
                  controller: strapController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Strap Color',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'this field is required';
                    }
                    return null;
                  },
                  controller: highlightController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Highlights',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'this field is required';
                    }
                    return null;
                  },
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration:  InputDecoration(

                    border: OutlineInputBorder(),
                    labelText: 'Price',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'this field is required';
                    }
                    return null;
                  },
                  controller: statusController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Status',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'this field is required';
                    }
                    return null;
                  },
                  controller: imageController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Image Url',
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child:
                  ElevatedButton(

                    style: ElevatedButton.styleFrom(
                      backgroundColor:Color(0xff092f92) ,

                      shape: StadiumBorder(),
                    ),
                    child: const Text('Add item',  style: TextStyle(fontSize: 16,color: Colors.white)),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        bool b;
                        if( statusController.text.toLowerCase() =='true'){
                          b=true;
                        }
                        else{
                          b=false;
                        }
                        Product1 p=Product1(productName: nameController.text, strapColor: strapController.text, highlights: highlightController.text, price: double.parse(priceController.text.toString()), status: b.toString(), image: imageController.text);
                        model.additem(p);
                        navigationService.previousRoute;
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );
                      }

                    },
                  )
              ),


            ],
          ),
        )
    );


  }
}
