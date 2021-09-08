import 'package:flutter/material.dart';
import 'package:next_step/Screen/homePageWidget/fourthSection/forthSection.dart';
import 'package:next_step/Screen/homePageWidget/secondSection/secondSection.dart';
import 'package:next_step/Screen/homePageWidget/thirdSection/thirdSection.dart';
import 'package:next_step/helper/firebaseHelper.dart';
import 'package:next_step/helper/providerHelper.dart';
import 'package:provider/provider.dart';

import 'homePageWidget/firstSection/homePageFirstSection.dart';

class HomePage extends StatefulWidget {
  static final id = 'homePage';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool loading = false;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      context.read<MyHelper>().newUser =
          await FirebaseHelper.getUserByKey(context.read<MyHelper>().userKey);
      setState(() {
        loading = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? (context.watch<MyHelper>().homePageFooterNum == 1
            ? HomePageFirstScreen()
            : context.watch<MyHelper>().homePageFooterNum == 2
                ? HomePageSecondSection()
                : context.watch<MyHelper>().homePageFooterNum == 3
                    ? HomePageThirdSection()
                    : HomePageFourthSection())
        : Center(
            child: CircularProgressIndicator(),
          );
  }
}
