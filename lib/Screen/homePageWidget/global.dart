import 'package:flutter/material.dart';
import 'package:next_step/helper/providerHelper.dart';
import 'package:provider/provider.dart';
import '../../constant.dart';

class FooterSection extends StatefulWidget {
  @override
  _FooterSectionState createState() => _FooterSectionState();
}

class _FooterSectionState extends State<FooterSection> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        decoration: BoxDecoration(
            color: firstColor,
            borderRadius: BorderRadius.all(Radius.circular(50))),
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                context.read<MyHelper>().setInHomeScreenListPickedItem(1);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Icon(
                      Icons.home,
                      color: Colors.white,
                    ),
                    context.watch<MyHelper>().homePageFooterNum == 1
                        ? Active()
                        : SizedBox(),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                context.read<MyHelper>().setInHomeScreenListPickedItem(2);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Icon(
                      Icons.collections_bookmark,
                      color: Colors.white,
                    ),
                    context.watch<MyHelper>().homePageFooterNum == 2
                        ? Active()
                        : SizedBox(),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                context.read<MyHelper>().setInHomeScreenListPickedItem(3);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    Icon(
                      Icons.favorite,
                      color: Colors.white,
                    ),
                    context.watch<MyHelper>().homePageFooterNum == 3
                        ? Active()
                        : SizedBox(),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                context.read<MyHelper>().setInHomeScreenListPickedItem(4);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    context.watch<MyHelper>().homePageFooterNum == 4
                        ? Active()
                        : SizedBox(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Active extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.maximize,
      color: Colors.white,
      size: 13,
    );
  }
}
