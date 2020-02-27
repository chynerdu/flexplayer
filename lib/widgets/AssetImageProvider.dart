import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:typed_data';

class AssetImageProvider extends StatelessWidget {
  final String albumArt;
  AssetImageProvider(this.albumArt);

  Widget build(BuildContext context) {
    if (albumArt != null ) {
      String imagePath =  '$albumArt';

      Uint8List loadData() {
        File file = File(imagePath);
        Uint8List bytes = file.readAsBytesSync();
        return bytes;
      }
      ImageProvider imageProvider = new MemoryImage(loadData()); 
      return Image.file(new File('$imageProvider'));
    } else {
      return Image(image: new ExactAssetImage("assets/image3.jpg"));
    }
  }
}