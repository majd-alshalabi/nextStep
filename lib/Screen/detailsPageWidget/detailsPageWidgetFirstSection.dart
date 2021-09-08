import 'package:flutter/material.dart';
import 'package:next_step/constant.dart';
import 'package:next_step/helper/firebaseHelper.dart';
import 'package:next_step/helper/providerHelper.dart';
import 'package:provider/provider.dart';

class FirstSection extends StatefulWidget {
  @override
  _FirstSectionState createState() => _FirstSectionState();
}

class _FirstSectionState extends State<FirstSection> {
  var myPlace;
  Icon icon = Icon(Icons.favorite_border, color: firstColor);

  @override
  void initState() {
    super.initState();
    myPlace = context.read<MyHelper>().getByIndex(context.read<MyHelper>().idx);
    if (context.read<MyHelper>().newUser['places']['${myPlace["name"]}']
            ['like'] ==
        true) {
      icon = Icon(Icons.favorite, color: firstColor);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: context.watch<MyHelper>().showMoreText == true ? 1 : 3,
      child: Builder(
        builder: (context) => Stack(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50)),
                image: DecorationImage(
                    image: AssetImage('assates/images/${myPlace["image"]}'),
                    fit: BoxFit.cover),
              ),
              child: SafeArea(
                child: Container(
                  padding: EdgeInsets.only(bottom: 40, left: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShadowText(
                        '${myPlace["place"]}',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: firstFont,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      ShadowText(
                        '${myPlace["name"]}',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: firstFont,
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              actions: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.4),
                  ),
                  child: IconButton(
                    onPressed: () {
                      if (icon.icon == Icons.favorite_border) {
                        context.read<MyHelper>().newUser['places']
                            ['${myPlace["name"]}']['like'] = true;
                        setState(() {
                          icon = Icon(
                            Icons.favorite,
                            color: firstColor,
                          );
                        });
                      } else {
                        context.read<MyHelper>().newUser['places']
                            ['${myPlace["name"]}']['like'] = false;
                        setState(() {
                          icon = Icon(
                            Icons.favorite_border,
                            color: firstColor,
                          );
                        });
                      }
                      FirebaseHelper.updateDocument(
                          context.read<MyHelper>().userKey,
                          context.read<MyHelper>().newUser);
                    },
                    icon: icon,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
