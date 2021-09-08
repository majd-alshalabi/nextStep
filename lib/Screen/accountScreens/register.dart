import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:next_step/helper/firebaseHelper.dart';
import 'package:next_step/helper/providerHelper.dart';
import 'package:next_step/helper/sharedPre.dart';
import 'package:provider/provider.dart';
import '../../constant.dart';
import '../homePage.dart';

class Register extends StatefulWidget {
  static final String id = 'register';

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool spiningBool = false;
  String errorMassage = '';

  TextEditingController usernameController = TextEditingController();
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
                            errorMassage = '';
                          });
                        }),
                    SizedBox(
                      height: 20,
                    ),
                    InputContainer(
                      controller: usernameController,
                      newWidth: MediaQuery.of(context).size.width,
                      placeHolderText: 'User Name',
                      onchanged: (newText) {
                        setState(() {
                          errorMassage = '';
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
                          errorMassage = '';
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
                      buttonText: 'Register',
                      width: 150,
                      buttonFunction: () async {
                        if (usernameController.text.isEmpty ||
                            emailController.text.isEmpty ||
                            passwordController.text.isEmpty)
                          setState(() {
                            errorMassage = 'fill all the fields';
                          });
                        else if (usernameController.text.length < 6) {
                          setState(() {
                            errorMassage =
                                'your name must be longer than 5 Letter';
                          });
                        } else {
                          setState(() {
                            spiningBool = true;
                          });
                          try {
                            UserCredential userCredential = await FirebaseAuth
                                .instance
                                .createUserWithEmailAndPassword(
                                    email: emailController.text,
                                    password: passwordController.text);
                            if (userCredential != null) {
                              Map temp = context.read<MyHelper>().user;
                              temp['name'] = usernameController.text;
                              temp['email'] = emailController.text;
                              FirebaseHelper.addUser(temp);

                              context
                                  .read<MyHelper>()
                                  .addEmailAndUserName(temp);
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
                            if (e.code == 'weak-password') {
                              setState(() {
                                errorMassage =
                                    'The password provided is too weak.';
                              });
                            } else if (e.code == 'email-already-in-use') {
                              setState(() {
                                errorMassage =
                                    'The account already exists for that email.';
                              });
                            } else if (e.code == 'invalid-email') {
                              setState(() {
                                errorMassage = 'invalid email or password.';
                              });
                            }
                          } catch (e) {
                            setState(() {
                              errorMassage = 'Connection Error';
                            });
                          }
                          setState(() {
                            spiningBool = false;
                          });
                        }
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
