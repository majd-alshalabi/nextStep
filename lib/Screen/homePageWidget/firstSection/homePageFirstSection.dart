import 'package:flutter/material.dart';
import 'package:next_step/Screen/homePageWidget/firstSection/firstSectionHomePageWidget.dart';

import '../../../constant.dart';
import '../../searchScreen.dart';
import '../global.dart';

class HomePageFirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        endDrawer: Container(
          width: 2 * MediaQuery.of(context).size.width / 3,
          child: DrawerWidget(),
        ),
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey[100],
        body: Builder(
          builder: (context) => Stack(
            children: <Widget>[
              AppbarWidget(),
              SafeArea(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          flex: 1,
                          child: Align(
                              alignment: Alignment.bottomCenter,
                              child: FirstSection())),
                      SizedBox(
                        height: 20,
                      ),
                      SearchSection(onclick: () {
                        Navigator.pushNamed(context, SearchScreen.id);
                      }),
                      SizedBox(
                        height: 10,
                      ),
                      ThiredSection(),
                      SizedBox(
                        height: 30,
                      ),
                      FourthSection(),
                      FooterSection()
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
