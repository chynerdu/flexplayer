import 'package:flutter/material.dart';

// Widget 
import './list-item.dart';

class ContactListing extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _ContactListing();
  }
}

class _ContactListing extends State<ContactListing> {
    ScrollController scrollController;
    final ScrollController controller = ScrollController();
  Widget build (BuildContext context) {
    return Flexible(
      child: ListView.builder(
        itemCount: 12,
        itemBuilder: (BuildContext context, int index) {
          return Column(children: <Widget>[
            ContactItem()
          ]);
        }
      )
    );
  }
}