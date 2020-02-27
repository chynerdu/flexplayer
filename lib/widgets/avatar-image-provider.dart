import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:typed_data';

class CircleAvaterImageProvider extends StatelessWidget {
  final String albumArt;
  CircleAvaterImageProvider(this.albumArt);

  Widget build(BuildContext context) {
    if (albumArt != null ) {
      String imagePath =  '$albumArt';

      Uint8List loadData() {
        File file = File(imagePath);
        Uint8List bytes = file.readAsBytesSync();
        return bytes;
      }
      ImageProvider imageProvider = new MemoryImage(loadData()); 
      return CircleAvatar(
        // child: Image.file(new File(imageProvider))
        backgroundImage: imageProvider
      );
    } else {
      return CircleAvatar(
        backgroundImage: AssetImage('assets/image2.jpg')    
      );
    }
  }
}