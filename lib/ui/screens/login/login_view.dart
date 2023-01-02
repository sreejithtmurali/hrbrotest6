import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hrbrotest/app/app.router.dart';
import 'package:hrbrotest/app/utils.dart';
import 'package:hrbrotest/ui/screens/home/home_view.dart';

import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../../constants/assets.gen.dart';
import 'login_viewmodel.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.nonReactive(
      builder: (context, viewModel, child) =>
          Scaffold(
        body:
        StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context,snapshot){
              if (snapshot.connectionState==ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if(snapshot.hasData){
               return HomeView() ;
              }
              else if(snapshot.hasError){
                return const Center(child: Text('Something went WRONG'),);
              }
              else {
                return Center(child: _UserLoginForm());
              }
            }
        ),





        // floatingActionButton: FloatingActionButton(
        //   onPressed: () => viewModel.updateTitle(),
        // ),
      ),
      viewModelBuilder: () => LoginViewModel(),
    );
  }
}

class _UserLoginForm extends HookViewModelWidget<LoginViewModel> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget buildViewModelWidget(BuildContext context, LoginViewModel model) {
    var usernameController = useTextEditingController();
    var passwordController = useTextEditingController();

    return Form(
      key: _formKey,
        child:
        Center(
          child: ListView(
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(top: 100),
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
                    'Login to continue',
                    style: TextStyle(fontSize: 18,color: Color(0xff092f92),fontWeight:FontWeight.bold ),
                  )),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Username';
                    }
                    return null;
                  },
                  controller: usernameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'User Name',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter password';
                    }
                    return null;
                  },
                  obscureText: true,
                  controller: passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
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
                    child: const Text('Login',  style: TextStyle(fontSize: 16,color: Colors.white)),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        model.submitLogin(
                            usernameController.text, passwordController.text);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );
                      }
                    }
                  )
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                     Text('or',style: TextStyle(fontSize: 14,color: Color(0xff092f92)),),

                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32.0),
                child: Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton.icon(


                      style: ElevatedButton.styleFrom(

                        backgroundColor:Color(0xffF6F6F6) ,

                        shape: StadiumBorder(),
                      ),
                      label: const Text('Continue with Google',  style: TextStyle(fontSize: 16,color: Colors.grey,
                      )),
                      onPressed: () {

                   model.googleLogin();
                      }, icon: Assets.images.img.image(width: 18,height: 18),
                    )
                ),
              ),

            ],
          ),
        )
    );


  }
}
