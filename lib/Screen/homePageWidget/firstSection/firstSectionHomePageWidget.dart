import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:next_step/Screen/accountScreens/welcomeScreen.dart';
import 'package:next_step/Screen/detailsScreen.dart';
import 'package:next_step/constant.dart';
import 'package:next_step/helper/providerHelper.dart';
import 'package:next_step/helper/sharedPre.dart';
import 'package:provider/provider.dart';

class FourthSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 300.0,
        aspectRatio: 16 / 9,
        viewportFraction: 0.8,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
      ),
      items: context.read<MyHelper>().places.asMap().entries.map((idx) {
        return Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () {
                context.read<MyHelper>().setIdx(idx.key);
                context.read<MyHelper>().showLess();
                context.read<MyHelper>().setIndetailsScreenListPickedItem(1);
                Navigator.pushNamed(context, DetailsScreen.id);
              },
              child: SliderWidget(idx.value),
            );
          },
        );
      }).toList(),
    );
  }
}

class SliderWidget extends StatelessWidget {
  final idx;
  SliderWidget(this.idx);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        image: DecorationImage(
            image: AssetImage('assates/images/${idx["image"]}'),
            fit: BoxFit.cover),
      ),
      child: Container(
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(15),
                alignment: Alignment.topLeft,
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: firstColor),
                    padding: EdgeInsets.all(15),
                    child: ShadowText(
                      '\$ ${idx["price"]}',
                      style: TextStyle(color: Colors.white),
                    )),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 30, bottom: 30),
                alignment: Alignment.bottomLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ShadowText(
                      '${idx["name"]}',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: firstFont,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: Colors.white,
                        ),
                        ShadowText(
                          '${idx["place"]}',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: firstFont,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ThiredSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconWidget(
          widgetText: 'Honeymoon',
          widgetIcon: Icon(Icons.favorite),
          onclick: () {},
        ),
        IconWidget(
            widgetText: 'Family',
            widgetIcon: Icon(Icons.family_restroom),
            onclick: () {}),
        IconWidget(
            widgetText: 'Nature',
            widgetIcon: Icon(Icons.nature_people),
            onclick: () {}),
        IconWidget(
            widgetText: 'Friends',
            widgetIcon: Icon(Icons.people),
            onclick: () {}),
      ],
    );
  }
}

class IconWidget extends StatelessWidget {
  final String widgetText;
  final Icon widgetIcon;
  final Function onclick;

  const IconWidget({this.widgetText, this.widgetIcon, this.onclick});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onclick,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: widgetIcon,
            onPressed: onclick,
            color: Colors.grey[600],
          ),
          Text(
            widgetText,
            style: TextStyle(
                fontSize: 12,
                fontFamily: firstFont,
                fontWeight: FontWeight.w900),
          )
        ],
      ),
    );
  }
}

class FirstSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: new TextSpan(
        style: new TextStyle(
            fontSize: 40.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: firstFont),
        children: <TextSpan>[
          TextSpan(text: 'Design & Book Amazing'),
          TextSpan(text: ' Holiday', style: new TextStyle(color: firstColor)),
          TextSpan(text: ' packages')
        ],
      ),
    );
  }
}

class AppbarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.segment,
            color: Colors.grey[600],
          ),
          onPressed: () {
            Scaffold.of(context).openEndDrawer();
          },
        ),
      ],
    );
  }
}

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SafeArea(
            child: Card(
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            context.read<MyHelper>().newUser['name'],
                            style: TextStyle(
                                fontFamily: firstFont,
                                fontWeight: FontWeight.bold,
                                fontSize: 35),
                          ),
                          Text(context.read<MyHelper>().newUser['email'],
                              style: TextStyle(
                                  fontFamily: firstFont,
                                  fontWeight: FontWeight.w400)),
                        ],
                      ),
                    ),
                    CircleAvatar(
                      radius: 50,
                      child: Image(
                          image: AssetImage('assates/images/suitcases.png')),
                    ),
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              await SharedPreHelper.setHaveLogedIn(false);
              Navigator.pushReplacementNamed(context, WelcomeScreen.id);
            },
            child: Card(
              child: Container(
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [Icon(Icons.logout), Text('Log Out')],
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
