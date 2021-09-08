import 'package:flutter/material.dart';

import 'detailsPageWidgetFirstSection.dart';
import 'detailsWidgetSecondSection.dart';

class DetailsWidgets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FirstSection(),
        SizedBox(
          height: 20,
        ),
        SecondSection()
      ],
    );
  }
}
