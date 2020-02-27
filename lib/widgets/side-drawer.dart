import 'package:flutter/material.dart';
import '../theme-data.dart';

class SideDrawer extends StatelessWidget {
   Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        // padding: EdgeInsets.only(left:0), 
        decoration: BoxDecoration(
          color: Color(0xff0d0d0d),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.black,
                image: new DecorationImage(
                  colorFilter:
                    ColorFilter.mode(Theme.of(context).buttonColor.withOpacity(0.2), BlendMode.darken),
                  fit: BoxFit.cover,
                  image: new ExactAssetImage("assets/image3.jpg")
                )
              ),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                verticalDirection: VerticalDirection.down,
                children: <Widget>[
                  Text('FlexPlayer', 
                  style: KontactTheme.display1
                  ),
                  Text('klickworld.chinedu@gmail.com',
                    style: KontactTheme.caption
                    ),
                ],)
              
            ),
            Container(
            child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                    Container(
                      child: ListTile(
                        dense: true,
                        leading: Icon(Icons.music_note, size:18, color:Colors.white),
                        title: Text('All Songs',
                         style: KontactTheme.titleDarkBg),
                        onTap: () {
                          
                        },
                      ),
                    ),
                    Divider(),
                  
                  ]  // LogoutListTile()
              ),
            ]
            )
            )
          ],
        ),
      )
    );
  }
}