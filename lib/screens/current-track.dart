import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:scoped_model/scoped_model.dart';
import '../scoped-models/main.dart';
import 'package:flute_music_player/flute_music_player.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../theme-data.dart';
// widgets
import '../widgets/media-slider.dart';

class CurrentTrack extends StatefulWidget {
  final MainModel model;
  dynamic isPlaying;
  // int index;
  CurrentTrack(this.model, this.isPlaying);
  @override
  State<StatefulWidget> createState() {
    return _CurrentTrack();
  }
}

 
class _CurrentTrack extends State <CurrentTrack> {
  dynamic _isPlaying;
  final MainModel _model = MainModel();
  MusicFinder audioPlayer;
  Duration duration;

  // get durationText => duration != null ? duration.toString().split('.').first : '';
  // get positionText => position != null ? position.toString().split('.').first : '';

  // StreamSubscription _positionSubscription;
  // StreamSubscription _audioPlayerStateSubscription;

  
  
    @override
  initState() {
    // widget.model.trackPosition.listen((Duration position) {
      // setState(() {
      //   audioPlayer.setDurationHandler((Duration d) {
      //   duration = d;
      //   widget.model.setTrackDuration(duration);
      //   // _trackDuration = duration;
      //     print('duration $duration');
      // });
      //   // bodyTheming = flexPlayThemeDarkBoxDecoration;
      // });
    // });
    // widget.model.trackPosition.listen((Duration position) {
    //   setState(() {
    //     _trackPosition = position;
    //     // bodyTheming = flexPlayThemeDarkBoxDecoration;
    //   });
    // });
    _isPlaying = widget.isPlaying;
    widget.model.isPlaying.listen((dynamic isPlaying) {
      setState(() {
        _isPlaying = isPlaying;
      });
    });
    audioPlayer = new MusicFinder();
    // audioPlayer.setPositionHandler((Duration d) {
    //   setState(() {
    //     position = d;
    //     // isNextTrack = true;
    //     // print('position inner $position');
    //   });
    // });
  
    // audioPlayer.setCompletionHandler(() {
    //       // onComplete();
    //       // isNextTrack = false;
    //       // position = widget.model.trackDuration;
    //       widget.model.handlePlayBack(widget.model.allSongs[widget.model.currentTrackIndex].uri, widget.model.currentTrackIndex, widget.model.allSongs);
    //       // Future.delayed(new Duration(seconds: 5));
    //       // resetPosition();
    //       setState(() {
          
    //     });
        
    //       print('song completed');
    //   });
    super.initState();
     audioPlayer = new MusicFinder();
  }

  // @override
  // void dispose() {
  //   audioPlayer.stop();
  //   super.dispose();
  // }

  // void initAudioPlayer() {
  //   MusicFinder audioPlayer;
  //   audioPlayer = new MusicFinder();
  //   _positionSubscription = audioPlayer.onAudioPositionChanged
  //       .listen((p) => setState(() => position = p));
  //   _audioPlayerStateSubscription =
  //       audioPlayer.onPlayerStateChanged.listen((s) {
  //     if (widget.isPlaying == 'playing') {
  //       setState(() => duration = audioPlayer.duration);
  //     } else if (widget.isPlaying == 'stopped') {
  //       onComplete();
  //       setState(() {
  //         position = duration;
  //       });
  //     }
  //   }, onError: (msg) {
  //     setState(() {
  //       playerState = PlayerState.stopped;
  //       duration = new Duration(seconds: 0);
  //       position = new Duration(seconds: 0);
  //     });
  //   });
  // }

  Widget buildAlbumArt(albumArt) {
    if(albumArt != null) {
      String imagePath =  '$albumArt';

    Uint8List loadData() {
      File file = File(imagePath);
      Uint8List bytes = file.readAsBytesSync();
      return bytes;
    }
    ImageProvider imageProvider = new MemoryImage(loadData()); 
      return Padding(
        padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
        child: Container(
        width: 200.0,
        height: 200.0,
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
          image: new DecorationImage(
              fit: BoxFit.cover,
              image: imageProvider
          )
        )),
      );
    } else {
      return Padding(
        padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
        child: Container(
        width: 200.0,
        height: 200.0,
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
          image: new DecorationImage(
              fit: BoxFit.cover,
              image: new AssetImage(
                  'assets/image2.jpg')
          )
        )),
      );
    }
  }
  Widget playBackMode(model) {
    print('return ${widget.model.playBackMode}');
   if (widget.model.playBackMode == 2) {
     return Container(
      padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
      child: IconButton(
        icon: Icon(Icons.repeat, color: Color(0xffffa500)),
        onPressed: () {
          widget.model.setPlayBackMode(0);
        },
      ),
    );
   } else if (widget.model.playBackMode == 1) {
     return Container(
      padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
      child: IconButton(
        icon: Icon(Icons.repeat_one, color: Color(0xffffa500)),
        onPressed: () {
          widget.model.setPlayBackMode(2);
        },
      ),
    );
   } else {
     return Container(
      padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
      child: IconButton(
        icon: Icon(Icons.repeat, color: Colors.white),
        onPressed: () {
          widget.model.setPlayBackMode(1);
        },
      ),
    );
   }
  }

    Widget shuffle(model) {
   if (widget.model.shuffle == 0) {
     return Container(
      padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
      child: IconButton(
        icon: Icon(Icons.shuffle, color: Colors.white),
        onPressed: () {
          widget.model.setShuffle(1);
        },
      ),
    );
   } else {
     return Container(
      padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
      child: IconButton(
        icon: Icon(Icons.shuffle, color: Color(0xffffa500)),
        onPressed: () {
          widget.model.setShuffle(0);
        },
      ),
    );
   }
  }
  Widget buildPausePlay(model) {
    if (_isPlaying == 'playing' ) {
      return Container(
        child: IconButton(
          icon: Icon(Icons.pause, color: Colors.white),
          onPressed: () {
            model.pause();
            
            // Future.delayed(new Duration(seconds: 5));
            // print('is now playing $_isPlaying');
            // print('current status ${widget.isPlaying}');
          },
        ),
      );
    } else {
      return Container(
        child: IconButton(
          icon: Icon(Icons.play_arrow, color: Colors.white),
          onPressed: () {
             
            // if (widget.isPlaying != 'stopped') {
            //   model.stop();
            // }
            model.play(model.allSongs[model.currentTrackIndex].uri, model.currentTrackIndex, model.allSongs);
            // Future.delayed(new Duration(seconds: 10));
            print('is now playing 2 $_isPlaying');
            print('current status 2 ${widget.isPlaying}');
          },
        ),
      );
    }
  }
  void rebuildAllChildren(BuildContext context) {
    // print('next track $isNextTrack');
      void rebuild(Element el) {
        el.markNeedsBuild();
        el.visitChildren(rebuild);
      }
      (context as Element).visitChildren(rebuild);
  }
// @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(builder: (BuildContext context, Widget child, MainModel model) {
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
        appBar: AppBar(
          backgroundColor: Colors.transparent,        
          centerTitle: true,
          title: Text('Now Playing',
          style: KontactTheme.headline),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.playlist_play),
              onPressed: () {
                // Navigator.pushNamed<bool>(
                //   context, '/search'                  
                // );
                // showSearch(
                //   context: context,
                //   delegate: CustomSearchDelegate(),
                // );
              },
            ),
        ],),
        body: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.transparent,
          ),
          child: Padding(
            padding: EdgeInsets.all(23),
            child: ListView(
              children: <Widget>[
                SizedBox(height: 20,),
                Form(
                  child: Column(
                    children: <Widget>[
                      buildAlbumArt(model.allSongs[model.currentTrackIndex].albumArt),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                        child: Text('${model.allSongs[model.currentTrackIndex].title}',
                          style: KontactTheme.titleDarkBg
                        ),
                      ),
                      Padding(
                        // ${widget.media.artist}
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                        child: Text('${model.allSongs[model.currentTrackIndex].artist} - ${model.allSongs[model.currentTrackIndex].album}',
                          style: KontactTheme.subtitleDarkBg
                        ),
                      ),
                      widget.model.trackDuration == null
                      ? new Container()
                      : MediaSlider(widget.model, widget.model.trackDuration),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                        // loop
                        playBackMode(widget.model),
                        // controls
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                child: IconButton(
                                  icon: Icon(Icons.skip_previous, color: Colors.white),
                                  onPressed: () {
                    
                                    audioPlayer.stop();
                                    // print('all songs ${model.allSongs.length}');
                                    widget.model.previous(model.currentTrackIndex, widget.model.allSongs);
                                    Future.delayed(new Duration(seconds: 5));
                                    rebuildAllChildren(context);
                                  },
                                ),
                              ),
                              buildPausePlay(model),
                              Container(
                                child: IconButton( 
                                  icon: Icon(Icons.skip_next, color: Colors.white),
                                  onPressed: () {
                                    // print('tapped');
                                    audioPlayer.stop();
                                    // print('all songs ${model.allSongs.length}');
                                    widget.model.skip(model.currentTrackIndex, widget.model.allSongs);
                                    Future.delayed(new Duration(seconds: 5));
                                    rebuildAllChildren(context);
                                  },
                                ),
                              ),
                            ],
                          )
                        ),
                        // shuffle
                        shuffle(model),
                      ],),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    });
  }
}