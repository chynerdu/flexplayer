import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped-models/main.dart';
import 'package:flute_music_player/flute_music_player.dart';

class MediaSlider extends StatefulWidget {
  final MainModel model;
  final Duration trackDuration;

  MediaSlider(this.model, this.trackDuration);
  @override
  State<StatefulWidget> createState() {
    return _MediaSlider();
  }
}

class _MediaSlider extends State<MediaSlider> {
  final MainModel _model = MainModel();
  MusicFinder audioPlayer;
  int _soungCount = 0;
  // Duration _trackPosition;
  Duration duration;
  Duration position;
  bool isNextTrack = false;
  @override
  void initState() {
     widget.model.songChangeCount.listen((int count) {
      setState(() {
        _soungCount = count;
        print('new song count $_soungCount');
        // bodyTheming = flexPlayThemeDarkBoxDecoration;
      });
    });
    audioPlayer = new MusicFinder();
      print('calling handler');
      audioPlayer.setPositionHandler((Duration d) {
        setState(() {
          position = d;
          // print('position inner $position');
        });
          // print('position $position');
      });
        audioPlayer.setCompletionHandler(() {
          // onComplete();
          isNextTrack = false;
          // position = widget.model.trackDuration;
          widget.model.handlePlayBack(widget.model.allSongs[widget.model.currentTrackIndex].uri, widget.model.currentTrackIndex, widget.model.allSongs);
          // Future.delayed(new Duration(seconds: 5));
          resetPosition();
        //   setState(() {
          
        // });
        
          print('song completed');
      });
    super.initState();
    // audioPlayer = new MusicFinder();
  }

  resetPosition() {
    audioPlayer.setPositionHandler((Duration d) {
      setState(() {
        position = d;
        isNextTrack = true;
        print('position inner $position');
      });
    });
  }
  void rebuildAllChildren(BuildContext context) {
    print('next track $isNextTrack');
      void rebuild(Element el) {
        el.markNeedsBuild();
        el.visitChildren(rebuild);
      }
      (context as Element).visitChildren(rebuild);
  }

  Widget build(BuildContext context) {
    // if (isNextTrack == true) {
    //    (rebuildAllChildren(context));
    // }
    return ScopedModelDescendant<MainModel>(builder: (BuildContext context, Widget child, MainModel model) {
    return Column(
      children: <Widget>[
      Text('$position / ${widget.model.trackDuration}', style: TextStyle(color: Colors.white)),
      new Slider(
      activeColor: Color(0xffffa500),
      value:position?.inMilliseconds?.toDouble() ?? 0.0,
      onChanged: (double value) =>
          audioPlayer.seek((value / 1000).roundToDouble()),
      min: 0.0,
      max: widget.model.trackDuration.inMilliseconds.toDouble())
      ],
    );
    
    });
  }  
}