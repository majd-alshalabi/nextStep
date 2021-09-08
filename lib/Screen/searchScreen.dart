import 'package:flutter/material.dart';
import 'package:next_step/Screen/detailsScreen.dart';
import 'package:next_step/helper/firebaseHelper.dart';
import 'package:next_step/helper/providerHelper.dart';
import 'package:provider/provider.dart';

import '../constant.dart';

class SearchScreen extends StatefulWidget {
  static final String id = 'SearchScreen';

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    super.initState();
    context.read<MyHelper>().filterdArray();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        body: Container(
          margin: EdgeInsets.only(top: 30),
          child: Column(
            children: [
              Container(
                child: SearchSection(
                  onclick: () {
                    context.read<MyHelper>().filterdArray();
                  },
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: (context.read<MyHelper>().myFilterdArray != null &&
                          context.watch<MyHelper>().myFilterdArray.length != 0)
                      ? MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: ListView.builder(
                            itemCount:
                                context.watch<MyHelper>().myFilterdArray.length,
                            itemBuilder: (context, index) {
                              return ListViewItem(index: index);
                            },
                          ),
                        )
                      : Container(
                          child: Center(
                            child: Text('no data'),
                          ),
                        ),
                ),
              )
            ],
          ),
        ));
  }
}

class ListViewItem extends StatefulWidget {
  final int index;

  const ListViewItem({this.index});

  @override
  _ListViewItemState createState() => _ListViewItemState();
}

class _ListViewItemState extends State<ListViewItem> {
  Icon icon = Icon(Icons.favorite_border, color: firstColor);

  @override
  void initState() {
    super.initState();
    if (context.read<MyHelper>().newUser['places'][
                '${context.read<MyHelper>().myFilterdArray[widget.index]["name"]}']
            ['like'] ==
        true) {
      icon = Icon(Icons.favorite, color: firstColor);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<MyHelper>().showMoreText = false;
        context.read<MyHelper>().idx = context
            .read<MyHelper>()
            .places
            .indexOf(context.read<MyHelper>().myFilterdArray[widget.index]);
        Navigator.pushReplacementNamed(context, DetailsScreen.id);
      },
      child: Card(
        child: ListTile(
          title: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 150,
                  height: 150,
                  margin: EdgeInsets.symmetric(vertical: 5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    image: DecorationImage(
                        image: AssetImage(
                            'assates/images/${context.read<MyHelper>().myFilterdArray[widget.index]["image"]}'),
                        fit: BoxFit.cover),
                  ),
                ),
                Flexible(
                  child: Container(
                    padding: EdgeInsets.only(left: 10, top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.read<MyHelper>().myFilterdArray[widget.index]
                              ["name"],
                          style: firstTextStyle,
                        ),
                        Text(
                          context.read<MyHelper>().myFilterdArray[widget.index]
                              ["place"],
                          style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 15,
                              fontFamily: firstFont),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: () {
                        if (icon.icon == Icons.favorite_border) {
                          context.read<MyHelper>().newUser['places'][
                                  '${context.read<MyHelper>().myFilterdArray[widget.index]["name"]}']
                              ['like'] = true;
                          setState(() {
                            icon = Icon(
                              Icons.favorite,
                              color: firstColor,
                            );
                          });
                        } else {
                          context.read<MyHelper>().newUser['places'][
                                  '${context.read<MyHelper>().myFilterdArray[widget.index]["name"]}']
                              ['like'] = false;
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
