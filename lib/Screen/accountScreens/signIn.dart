import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:next_step/Screen/homePage.dart';
import 'package:next_step/constant.dart';
import 'package:next_step/helper/firebaseHelper.dart';
import 'package:next_step/helper/providerHelper.dart';
import 'package:next_step/helper/sharedPre.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  static final String id = 'signIn';

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool spiningBool = false;
  String errorMassage = '';
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: ModalProgressHUD(
        inAsyncCall: spiningBool,
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Hero(
                          tag: 'image',
                          child: Image(
                            width: 150,
                            image: AssetImage('assates/images/suitcases.png'),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 60, left: 20),
                          child: ShadowText(
                            'Next Step',
                            style:
                                TextStyle(fontSize: 40, fontFamily: firstFont),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    InputContainer(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      newWidth: MediaQuery.of(context).size.width,
                      placeHolderText: 'Email',
                      onchanged: (newText) {
                        setState(() {
                          errorMassage = "";
                        });
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InputContainer(
                      obscureTextValue: true,
                      controller: passwordController,
                      newWidth: MediaQuery.of(context).size.width,
                      placeHolderText: 'Password',
                      onchanged: (newText) {
                        setState(() {
                          errorMassage = "";
                        });
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      errorMassage,
                      style: TextStyle(color: Colors.red),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    MyButton(
                      buttonColor: firstColor,
                      buttonText: 'Sign In',
                      width: 150,
                      buttonFunction: () async {
                        setState(() {
                          spiningBool = true;
                        });
                        try {
                          UserCredential userCredential = await FirebaseAuth
                              .instance
                              .signInWithEmailAndPassword(
                                  email: emailController.text,
                                  password: passwordController.text);
                          if (userCredential != null) {
                            context.read<MyHelper>().setUserID(
                                await FirebaseHelper.getDocumentKey(
                                    'users', emailController.text));

                            await SharedPreHelper.setUserKey(
                                context.read<MyHelper>().userKey);
                            await SharedPreHelper.setHaveLogedIn(true);
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                HomePage.id, (route) => false);
                          }
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            setState(() {
                              errorMassage = 'No user found for that email.';
                            });
                          } else if (e.code == 'wrong-password') {
                            setState(() {
                              errorMassage =
                                  'Wrong password provided for that user.';
                            });
                          }
                        } catch (e) {
                          setState(() {
                            errorMassage = 'error while loading';
                          });
                        }
                        setState(() {
                          spiningBool = false;
                        });
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
