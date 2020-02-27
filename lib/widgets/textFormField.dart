import 'package:flutter/material.dart';


class CustomTextFormField extends StatelessWidget {
   final String placeholder;
   CustomTextFormField(this.placeholder);
  @override

  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
        color: Colors.white,
      ),
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white
          )
        ),
        labelText: placeholder,
        labelStyle: TextStyle(fontSize: 15,
        color: Colors.white)
      ),
    );
  }
}

