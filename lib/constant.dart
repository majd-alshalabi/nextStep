import 'dart:ui';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'helper/providerHelper.dart';

const Color firstColor = Color(0Xffff7680);
const String firstFont = 'OpenSansCondensed';
const String secondFont = 'YanoneKaffeesatz';

const TextStyle firstTextStyle =
    TextStyle(fontFamily: firstFont, fontWeight: FontWeight.bold, fontSize: 20);

const TextStyle mytextStyle = TextStyle(
  color: firstColor,
);

class MyButton extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final Function buttonFunction;
  final double width;

  MyButton(
      {this.buttonText, this.buttonColor, this.buttonFunction, this.width});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        color: buttonColor,
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
        elevation: 5.0,
        child: MaterialButton(
          onPressed: () {
            buttonFunction();
          },
          height: 42.0,
          minWidth: width,
          child: Text(
            buttonText,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class ShadowText extends StatelessWidget {
  ShadowText(this.data, {this.style}) : assert(data != null);

  final String data;
  final TextStyle style;

  Widget build(BuildContext context) {
    return new ClipRect(
      child: new Stack(
        children: [
          new Positioned(
            top: 2.0,
            left: 2.0,
            child: new Text(
              data,
              style: style.copyWith(color: Colors.black.withOpacity(0.5)),
            ),
          ),
          new BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
            child: new Text(data, style: style),
          ),
        ],
      ),
    );
  }
}

class SearchSection extends StatefulWidget {
  final Function onclick;

  SearchSection({this.onclick});

  @override
  _SearchSectionState createState() => _SearchSectionState();
}

class _SearchSectionState extends State<SearchSection> {
  TextEditingController myController = TextEditingController();

  @override
  void initState() {
    super.initState();
    myController.text = context.read<MyHelper>().searchWord;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
      ),
      padding: EdgeInsets.all(6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: TextField(
              onSubmitted: (value) {
                context.read<MyHelper>().setSearchWord(myController.text);
                widget.onclick();
                myController.clear();
              },
              controller: myController,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding:
                    EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                hintText: "Search for palces",
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.search,
              color: firstColor,
            ),
            onPressed: () {
              context.read<MyHelper>().setSearchWord(myController.text);
              widget.onclick();
              myController.clear();
            },
          ),
        ],
      ),
    );
  }
}

class InputContainer extends StatefulWidget {
  final String placeHolderText;
  final Function onchanged;
  final double newWidth;
  final TextEditingController controller;
  final bool obscureTextValue;
  final keyboardType;

  InputContainer(
      {this.placeHolderText,
      this.onchanged,
      this.newWidth,
      this.controller,
      this.obscureTextValue,
      this.keyboardType});
  @override
  _InputContainerState createState() => _InputContainerState();
}

class _InputContainerState extends State<InputContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.newWidth,
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
      ),
      padding: EdgeInsets.all(6),
      child: TextField(
        obscureText:
            widget.obscureTextValue == null ? false : widget.obscureTextValue,
        keyboardType: widget.keyboardType == null
            ? TextInputType.text
            : widget.keyboardType,
        controller: widget.controller,
        onChanged: (newText) {
          widget.onchanged(newText);
        },
        cursorColor: Colors.black,
        decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          contentPadding:
              EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
          hintText: widget.placeHolderText,
        ),
      ),
    );
  }
}
