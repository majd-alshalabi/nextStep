import 'package:flutter/material.dart';

import 'detailsPageWidget/detailsPageWidget.dart';

class DetailsScreen extends StatelessWidget {
  static final String id = 'detailsScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Container(child: DetailsWidgets())),
    );
  }
}
