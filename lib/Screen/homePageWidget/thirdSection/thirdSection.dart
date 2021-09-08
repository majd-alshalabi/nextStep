import 'package:flutter/material.dart';
import 'package:next_step/Screen/homePageWidget/global.dart';

class HomePageThirdSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                  child: Container(
                alignment: Alignment.center,
                child: Text('comming Soon'),
              )),
              FooterSection()
            ],
          )),
    );
  }
}
