import 'package:flutter/material.dart';


class SecondButton extends StatelessWidget {
   final Function initFunction;
   final String title;
   SecondButton(this.initFunction, this.title);
  @override

  Widget build(BuildContext context) {
    return MaterialButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
        Icon(Icons.add, color: Colors.white),
        Text(title,
          style: TextStyle(
          // fontSize: 15,
          fontFamily: 'SFUIDisplay',
          fontWeight: FontWeight.bold,
          color: Colors.white
        ),
      )
      ],),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: Color(0xffffa500),
      elevation: 0,
      minWidth: 350,
      onPressed: () {
       initFunction();
        }
    ,);
  }
}
