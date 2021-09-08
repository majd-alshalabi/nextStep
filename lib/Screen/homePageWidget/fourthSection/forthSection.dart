import 'dart:ui';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:next_step/Screen/homePageWidget/global.dart';
import 'package:next_step/constant.dart';
import 'package:next_step/helper/providerHelper.dart';

class HomePageFourthSection extends StatefulWidget {
  static String id = 'profileScreen';

  @override
  _HomePageFourthSectionState createState() => _HomePageFourthSectionState();
}

class _HomePageFourthSectionState extends State<HomePageFourthSection> {
  bool valid = false;
  TextEditingController controller = TextEditingController();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
              child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 3,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assates/images/Ojai.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                  child: Container(
                    decoration:
                        BoxDecoration(color: Colors.white.withOpacity(0.0)),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(top: 90),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 4),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                child: Container(
                  padding: EdgeInsets.only(top: 6),
                  alignment: Alignment.topCenter,
                  child: Text(
                    context.read<MyHelper>().newUser['name'],
                    style: TextStyle(fontFamily: secondFont, fontSize: 30),
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height / 6,
                left: MediaQuery.of(context).size.width / 2 - 75,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    image: DecorationImage(
                      image: AssetImage("assates/images/Ojai.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              )
            ],
          )),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: FooterSection())
        ],
      )),
    );
  }
}
