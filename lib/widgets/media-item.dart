import 'dart:io';
import 'dart:typed_data';
import 'package:flute_music_player/flute_music_player.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';
import '../theme-data.dart';
import '../scoped-models/main.dart';

// import '../screens/current-track.dart';
 
//  enum PlayerState { stopped, playing, paused }
// class MediaItem extends StatefulWidget {
  
//   final dynamic media;
//   dynamic isPlaying;
//   MediaItem(this.media, this.isPlaying);
//   @override
//   State<StatefulWidget> createState() {
//     return _MediaItem();
//   }
// }
class MediaItem extends StatelessWidget {
  final dynamic media;
  dynamic isPlaying;
  int index;
  final MainModel model;
  MediaItem(this.media, this.isPlaying, this.index, this.model);
  dynamic _isPlaying = 'stopped';
  final MainModel _model = MainModel();
  MusicFinder audioPlayer;
  // PlayerState playerState = PlayerState.stopped;
  // get isPlaying => playerState == PlayerState.playing;
  // get isPaused => playerState == PlayerState.paused;
  // @override
  // initState() {
  //   _model.isPlaying.listen((dynamic isPlaying) {
  //     setState(() {
  //       _isPlaying = isPlaying;
  //     });
  //   });
  //   super.initState();
  //   audioPlayer = new MusicFinder();
    
  // }

  play() async {
    audioPlayer = new MusicFinder();
    print('playing $isPlaying');
    if (isPlaying != 'stopped') {
      print('stop called');
      await model.stop();
    }
     
    model.play(media.uri, index, model.allSongs);
    // print('is playing $_isPlaying');
  // await audioPlayer.stop();
  // final result = await audioPlayer.play(widget.media.uri);
  // if (result == 1) setState(() => playerState = PlayerState.playing);
}
_buttomSheet(media, loadData, BuildContext context) {
   ImageProvider imageProvider = new MemoryImage(loadData()); 
    return Container(
      alignment: Alignment.topLeft,
      padding: EdgeInsets.only(left: 0, right: 20, top: 20, bottom: 0),
      // margin: const EdgeInsets.only(top: 5, left: 0, right: 0),
      height: 350,
      width: double.infinity,
      decoration: BoxDecoration(
        // color: Colors.black87,
        gradient: LinearGradient(
          // Where the linear gradient begins and ends
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          // Add one stop for each color. Stops should increase from 0 to 1
          stops: [ 0.7, 0.9],
          colors: [
            Color(0xff000000),
            Color(0xff0d0d0d),
          ],
        ),
        boxShadow: [
          BoxShadow(
              blurRadius: 2, color: Colors.grey[600], spreadRadius: 1)
        ]
        ),
        child: ListView(
          children: [
            ListTile(
              leading: Image(
                image:imageProvider,
                width: 100.0,
                height: 120.0,
                fit: BoxFit.cover,
              ),
              title: Text(media.title,
                style: KontactTheme.titleDarkBg),
              subtitle: Text(media.artist,
                style: KontactTheme.subtitleDarkBg) 
            ),
            Divider(color: Colors.blueGrey),
            ListTile(
              title: Text('Track: ${media.title}', style: KontactTheme.titleDarkBg)
            ),
            ListTile(
              title: Text('Artist: ${media.artist}', style: KontactTheme.titleDarkBg)
            ),
            ListTile(
              title: Text('Album: ${media.album}', style: KontactTheme.titleDarkBg)
            ),
            ListTile(
              title: Text('Add To Playlist', style: KontactTheme.titleDarkBg)
            ),
            
          ]
        ),
    );
  }


  Widget build(BuildContext context) {
    
    if (media.albumArt != null ) {
    String imagePath =  '${media.albumArt}';

    Uint8List loadData() {
      File file = File(imagePath);
      Uint8List bytes = file.readAsBytesSync();
      return bytes;
    }
    ImageProvider imageProvider = new MemoryImage(loadData()); 
    return ScopedModelDescendant<MainModel>(builder: (BuildContext context, Widget child, MainModel model) {
      return ListTile(
      leading: CircleAvatar(
        // child: Image.file(new File(imageProvider))
        backgroundImage: imageProvider
      ),
        title: Text('${media.title}',
        style: KontactTheme.titleDarkBg
      ),
        subtitle: Text('${media.artist}',
        style: KontactTheme.subtitleDarkBg
      ),
      trailing: IconButton(
          icon: Icon(Icons.more_vert, color: Colors.white),
          onPressed: () {
            showBottomSheet(
              elevation: 20,
              context: context,
              builder: (context) {
                return _buttomSheet(media, loadData, context);
                
              } 
            );
          }
      ),
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => CurrentTrack(model, isPlaying)),
        // );
        if (isPlaying == 'stopped' || isPlaying == 'paused') {
          model.stop();
        }
        play();
        // print('all songs after playing ${model.currentStatus}');
        Future.delayed(new Duration(seconds: 5));
        // print('is playing  now $_isPlaying');
      },
    );
    });
    } else {
      return ScopedModelDescendant<MainModel>(builder: (BuildContext context, Widget child, MainModel model) {
      //  String imagePath =  '${media.albumArt}';
     return  ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage('assets/image2.jpg')
      
      ),
        title: Text(media.title,
        style: KontactTheme.titleDarkBg
      ),
        subtitle: Text(media.artist,
        style: KontactTheme.subtitleDarkBg
      ),
       onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => CurrentTrack(model, isPlaying)),
        // );
        if (isPlaying == 'stopped' || isPlaying == 'paused') {
          model.stop();
        }
        play();
        // print('all songs after playing ${model.currentStatus}');
        Future.delayed(new Duration(seconds: 5));
        // print('is playing  now $_isPlaying');
      },
      );
      }); 
    }
  }
}