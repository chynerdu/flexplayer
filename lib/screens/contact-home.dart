import 'package:flutter/material.dart';
import '../theme-data.dart';

// Widgets
import '../widgets/search-input.dart';
import '../widgets/contact-listing.dart';

class ContactList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ContactList();
  }
}

class _ContactList extends State<ContactList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          // Where the linear gradient begins and ends
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          // Add one stop for each color. Stops should increase from 0 to 1
          stops: [0.5, 0.4, 0.6, 0.8],
          colors: [
            // Colors are easy thanks to Flutter's Colors class.
            Colors.black12,
            Color(0xff767d89),
            Colors.black54,
            Colors.black,
          ],
        ),
        // color: Colors.black
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container( 
           width: MediaQuery.of(context).size.width,
           decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.transparent,
          ),
          
          child: Padding(
            padding: EdgeInsets.all(23), 
            child: Column(children: <Widget>[
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(height: 100,),
                    Container(
                      child: Text('My Contacts',
                        style: KontactTheme.headline
                      ) 
                    ),
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/avatar.jpg'),
                    )
                ],)
              ),
              Container(
                alignment: Alignment.center,
                child: SearchInput()
              ),
              Container(
                child: ContactListing()
              )
            ],)
            
          )   
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          child: Icon(Icons.add, color: Color(0xffffa500), size: 25),
          onPressed: () {
            Navigator.pushNamed(
              context, '/media'                  
            );
          }
        ,),
      )
    );
  }
}