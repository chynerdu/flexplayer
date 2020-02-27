import 'package:flutter/material.dart';
import '../theme-data.dart';

// widgets
import '../widgets/secondButton.dart';

class FlexPlayList extends StatefulWidget {
  @override

  State<StatefulWidget> createState() {
    return _FlexPlayList();
  }
}

class _FlexPlayList extends State<FlexPlayList> {
  initFunction() {
   Navigator.pushNamed<bool>(
    context, '/new-playlist'                  
   );
}
  Widget build(BuildContext context) {
    return new Container(
      child: Center(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          Container( 
            child: Text('No playlist created yet', style: KontactTheme.titleDarkBg),
          ),
          SizedBox(height: 10.0),
          SizedBox(width: 150.0,
          child: SecondButton(initFunction, 'Create Now')
          ),
        ],)
        // child:Text('No playList created yet', style: KontactTheme.titleDarkBg)
        )
      );
  }
}