import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped-models/main.dart';
import '../theme-data.dart';

// widget
import '../widgets/textFormField.dart';
import '../widgets/firstButton.dart';

Function bodyTheming = flexPlayThemeDarkBoxDecoration;

void initFunction() {

}

class NewPlaylistForm extends StatelessWidget {
   Widget build(BuildContext context) {
  return ScopedModelDescendant<MainModel>(builder: (BuildContext context, Widget child, MainModel model) {
    return Container(
      decoration: bodyTheming(),
      child: Scaffold(
        appBar: AppBar(
         centerTitle: true,
         backgroundColor: Colors.transparent,        
         title: Text('New Playlist',
            style: KontactTheme.headline
          ) ,
        ),
        backgroundColor: Colors.transparent,
        body: Container( 
           width: MediaQuery.of(context).size.width,
           decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.transparent,
          ),
          
          child: Container(
            padding: EdgeInsets.only(left:25, right: 25), 
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              Container(
                child: CustomTextFormField('Enter Playlist Title')
              ),
              SizedBox(height: 20.0),
              SizedBox(width: 150.0,
                child: FirstButton(initFunction, 'Create Playlist')
              ),
            ],)          
          )   
        ),
      )
    );
    });
   }
}