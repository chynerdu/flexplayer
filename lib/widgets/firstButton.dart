import 'package:flutter/material.dart';


class FirstButton extends StatelessWidget {
   final Function initFunction;
   final String title;
   FirstButton(this.initFunction, this.title);
  @override

  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: (){
        initFunction();
        //  Navigator.pushReplacementNamed(context, '/dashboard'); 
        // Navigator.pushReplacementNamed(context, '/listing');
      },
      child: Text(title,
      style: TextStyle(
        fontSize: 15,
        fontFamily: 'SFUIDisplay',
        fontWeight: FontWeight.bold,
        color: Colors.white
      ),
      ),
      color: Color(0xffffa500),
      elevation: 0,
      minWidth: 350,
      height: 40,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50)
      ),
    );
  }
}
