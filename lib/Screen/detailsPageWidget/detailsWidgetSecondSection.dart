import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:next_step/constant.dart';
import 'package:next_step/helper/firebaseHelper.dart';
import 'package:next_step/helper/providerHelper.dart';
import 'package:provider/provider.dart';

class SecondSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        child: Column(
          children: [
            ListWidget(),
            context.watch<MyHelper>().detailsScreenListPickedItem == 1
                ? OverViewWidget()
                : context.watch<MyHelper>().detailsScreenListPickedItem == 2
                    ? DetailsWidget()
                    : ReviewWidget(),
            context.watch<MyHelper>().detailsScreenListPickedItem == 3
                ? CommentWidgetFooter()
                : FooterWidget()
          ],
        ),
      ),
    );
  }
}

class CommentWidgetFooter extends StatefulWidget {
  @override
  _CommentWidgetFooterState createState() => _CommentWidgetFooterState();
}

class _CommentWidgetFooterState extends State<CommentWidgetFooter> {
  String comment;
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: 10,
      ),
      child: Row(
        children: [
          InputContainer(
            controller: controller,
            onchanged: (newText) {
              comment = newText;
            },
            placeHolderText: 'Enter Your Review',
            newWidth: 10 * MediaQuery.of(context).size.width / 12,
          ),
          IconButton(
            onPressed: () {
              controller.clear();
              FirebaseHelper.addComment(
                  context.read<MyHelper>().newUser['name'],
                  context
                      .read<MyHelper>()
                      .getByIndex(context.read<MyHelper>().idx)['name'],
                  comment);
            },
            icon: Icon(
              Icons.send,
              color: firstColor,
            ),
          )
        ],
      ),
    );
  }
}

class ReviewWidget extends StatefulWidget {
  @override
  _ReviewWidgetState createState() => _ReviewWidgetState();
}

class _ReviewWidgetState extends State<ReviewWidget> {
  bool spiningCir = false;

  @override
  void initState() {
    super.initState();
    setInitState();
  }

  void setInitState() async {
    context.read<MyHelper>().comments =
        await FirebaseHelper.getCollection('comments');
    setState(() {
      spiningCir = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: spiningCir
          ? Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('comments')
                        .orderBy('time', descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final myComments = snapshot.data.docs.where((element) =>
                            element['place'].contains(context
                                .read<MyHelper>()
                                .getByIndex(
                                    context.read<MyHelper>().idx)['name']));
                        List<Widget> comments = [];

                        for (var comment in myComments) {
                          final Widget myWidget =
                              CommentWidegt(comment: comment);
                          comments.add(myWidget);
                        }
                        return comments.isNotEmpty
                            ? ListView(reverse: true, children: comments)
                            : Container(
                                child: Center(
                                  child: Text('be The First One to Comment!'),
                                ),
                              );
                      } else {
                        return Container(
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                    },
                  )),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}

class CommentWidegt extends StatelessWidget {
  CommentWidegt({
    @required this.comment,
  });

  final QueryDocumentSnapshot<Object> comment;

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            comment['name'],
            style: TextStyle(
                fontSize: 10,
                color:
                    comment['name'] == context.read<MyHelper>().newUser['name']
                        ? firstColor
                        : Colors.black),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                  topLeft: Radius.circular(20)),
              color: Colors.white,
            ),
            padding: EdgeInsets.all(20),
            child: Text(
              comment['comment'],
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: secondFont,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          )
        ]);
  }
}

class FooterWidget extends StatefulWidget {
  @override
  _FooterWidgetState createState() => _FooterWidgetState();
}

class _FooterWidgetState extends State<FooterWidget> {
  String footerData = 'Book now';

  @override
  void initState() {
    super.initState();
    if (context.read<MyHelper>().newUser['places'][
                '${context.read<MyHelper>().getByIndex(context.read<MyHelper>().idx)["name"]}']
            ['book'] ==
        true) {
      footerData = 'cancel';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Text(
                  'Estimated cost',
                  style: mytextStyle,
                ),
                Text(
                  '\$ ${context.read<MyHelper>().getByIndex(context.read<MyHelper>().idx)["price"]}/person',
                  style: TextStyle(
                      fontFamily: firstFont,
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
          Expanded(
            child: MyButton(
              buttonColor: firstColor,
              buttonText: footerData,
              buttonFunction: () {
                if (footerData == 'Book now') {
                  context.read<MyHelper>().newUser['places'][
                          '${context.read<MyHelper>().getByIndex(context.read<MyHelper>().idx)["name"]}']
                      ['book'] = true;
                  setState(() {
                    footerData = 'Cancel';
                  });
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("You have booked this trip"),
                  ));
                } else {
                  context.read<MyHelper>().newUser['places'][
                          '${context.read<MyHelper>().getByIndex(context.read<MyHelper>().idx)["name"]}']
                      ['book'] = false;
                  setState(() {
                    footerData = 'Book now';
                  });
                }
                FirebaseHelper.updateDocument(context.read<MyHelper>().userKey,
                    context.read<MyHelper>().newUser);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DetailsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Easily generate Lorem Ipsum placeholder text in any number of characters, words sentences or paragraphs. Learn about the origins of the passage and its ...',
              style: TextStyle(fontFamily: firstFont, fontSize: 17),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DetailsIcon(
                  myIcon: Icon(Icons.timelapse, color: firstColor),
                  text: '4 Days',
                  secondText: 'Duration',
                ),
                DetailsIcon(
                  myIcon: Icon(Icons.location_on, color: firstColor),
                  text: '4 Days',
                  secondText: 'Distance',
                ),
                DetailsIcon(
                  myIcon: Icon(Icons.wb_sunny, color: firstColor),
                  text: '4 Days',
                  secondText: 'Sunny',
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class DetailsIcon extends StatelessWidget {
  final Icon myIcon;
  final String text;
  final String secondText;

  const DetailsIcon({this.myIcon, this.text, this.secondText});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            myIcon,
            SizedBox(
              width: 3,
            ),
            Text(text)
          ],
        ),
        Text(
          secondText,
          style: TextStyle(color: Colors.grey),
        )
      ],
    );
  }
}

class OverViewWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          context.read<MyHelper>().showMore();
        },
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: RichText(
              textAlign: TextAlign.start,
              text: TextSpan(
                style: TextStyle(
                    fontSize: 18.0, color: Colors.black, fontFamily: firstFont),
                children: <TextSpan>[
                  TextSpan(
                    text: context.watch<MyHelper>().showMoreText
                        ? context
                            .read<MyHelper>()
                            .getByIndex(context.read<MyHelper>().idx)["details"]
                        : context
                            .read<MyHelper>()
                            .getByIndex(context.read<MyHelper>().idx)["details"]
                            .substring(0, 400),
                  ),
                  TextSpan(
                      text: context.watch<MyHelper>().showMoreText
                          ? ''
                          : ' show more ...',
                      style: TextStyle(fontWeight: FontWeight.w900))
                ],
              ),
            )),
      ),
    );
  }
}

class ListWidget extends StatefulWidget {
  @override
  _ListWidgetState createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ListItem(
          textContaint: 'Overview',
          pickedItem: context.watch<MyHelper>().detailsScreenListPickedItem == 1
              ? true
              : false,
          onclick: () {
            context.read<MyHelper>().setIndetailsScreenListPickedItem(1);
          },
        ),
        ListItem(
          textContaint: 'Details',
          pickedItem: context.watch<MyHelper>().detailsScreenListPickedItem == 2
              ? true
              : false,
          onclick: () {
            context.read<MyHelper>().setIndetailsScreenListPickedItem(2);
            context.read<MyHelper>().showLess();
          },
        ),
        ListItem(
          textContaint: 'Review',
          pickedItem: context.watch<MyHelper>().detailsScreenListPickedItem == 3
              ? true
              : false,
          onclick: () {
            context.read<MyHelper>().setIndetailsScreenListPickedItem(3);
            context.read<MyHelper>().showLess();
          },
        ),
      ],
    );
  }
}

class ListItem extends StatefulWidget {
  const ListItem({this.pickedItem, this.textContaint, this.onclick});

  @override
  _ListItemState createState() => _ListItemState();

  final bool pickedItem;
  final String textContaint;
  final Function onclick;
}

class _ListItemState extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        child: Column(
          children: [
            Text(widget.textContaint,
                style: widget.pickedItem == true ? mytextStyle : null),
            Opacity(
              opacity: widget.pickedItem == true ? 1 : 0,
              child: Icon(
                Icons.spa,
                color: firstColor,
              ),
            )
          ],
        ),
      ),
      onTap: () {
        widget.onclick();
      },
    );
  }
}
