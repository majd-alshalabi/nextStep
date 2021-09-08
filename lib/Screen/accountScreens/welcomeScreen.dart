import 'package:flutter/material.dart';
import 'package:next_step/Screen/accountScreens/register.dart';
import 'package:next_step/Screen/accountScreens/signIn.dart';
import 'package:next_step/constant.dart';

class WelcomeScreen extends StatelessWidget {
  static final String id = 'welcomeScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomRight,
            stops: [0.4, 0.6],
            colors: [
              Colors.blue[100],
              Colors.white,
            ],
          ),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  child: Hero(
                    tag: 'image',
                    child: Image(
                      image: AssetImage('assates/images/suitcases.png'),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                    padding: EdgeInsets.only(bottom: 10),
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        RichText(
                          textAlign: TextAlign.center,
                          text: new TextSpan(
                            style: new TextStyle(
                                fontSize: 40.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: firstFont),
                            children: <TextSpan>[
                              new TextSpan(text: 'Enjoy every'),
                              new TextSpan(
                                  text: ' moments',
                                  style: new TextStyle(color: firstColor)),
                              new TextSpan(text: ' with us!')
                            ],
                          ),
                        ),
                        MyButton(
                          width: 150,
                          buttonColor: firstColor,
                          buttonText: 'Sign in',
                          buttonFunction: () {
                            Navigator.pushNamed(context, SignIn.id);
                          },
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, Register.id);
                          },
                          child: Container(
                            alignment: Alignment.topCenter,
                            child: Center(
                              child: Text(
                                'Register',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
