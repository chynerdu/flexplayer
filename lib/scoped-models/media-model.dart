// import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
// import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flute_music_player/flute_music_player.dart';
import 'package:rxdart/subjects.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'dart:math';

import './connected-model.dart';
// theme
import '../theme-data.dart';

// enum PlayerState { stopped, playing, paused }

mixin MediaModel on ConnectedModel {
  PublishSubject<dynamic> _isPlaying = PublishSubject();
  PublishSubject<int> _songChangeCount = PublishSubject();
  MusicFinder audioPlayer;
   List <Song> newsongs = [];
   List <Song> _album = [];
   String _status = 'fetching';
   int _currentTrackIndex = 0;
   Duration _trackDuration;
   PublishSubject<Duration> _trackPosition = PublishSubject();
  //  playbackm mode: 0 = none, 1 = repeat one, 2= repeat all
   int _playBackMode = 0;
   int _count = 0;
  //  shuffle 1 = on, 2 = off
   int _shuffle = 0;
   Random random = new Random();

  // PlayerState playerState = PlayerState.stopped;

  //  get isPlaying => playerState == PlayerState.playing;
  // get isPlaying {
  //    return playerState;
  // }

  PublishSubject<dynamic> get isPlaying {
    return _isPlaying;
  }

  List <Song> get allSongs {
    return List.from(newsongs);
  }

  List <Song> get album {
    return List.from(_album);
  }

  int get currentTrackIndex {
    return _currentTrackIndex;
  }

  String get currentStatus {
    return _status;
  }

  Duration get trackDuration {
    return _trackDuration;
  }

  // Duration get trackPosition {
  //   return _trackPosition;
  // }

  PublishSubject<Duration> get trackPosition {
    return _trackPosition;
  }

  PublishSubject<int> get songChangeCount {
    return _songChangeCount;
  }

  int get playBackMode {
    return _playBackMode;
  }

  int get shuffle {
    return _shuffle;
  }

  Future fetchSongs() async {
    print('fetching songs');
    List<Song> songs;
    try {
      songs = await MusicFinder.allSongs();
      // final dynamic encodedData = songs[4];
      // save songs to state
      // print('songs ${songs.length}');
      // print('first encoded $encodedData');
      // print('keys of encoded ${encodedData.albumArt}');
      if (songs.isNotEmpty) {
           newsongs = songs;
          _status = 'fetched'; 
          notifyListeners();
          // Future.delayed(new Duration(seconds: 5));
          print('delay complete');
        // audioPlayer.play(songs.first.uri);
        // audioPlayer.play(songs[4].uri);
      }
      return songs;
      
    } catch(e) {
      print(e.toString());
    }
    // newsongs = songs;
    // _status = 'songs fetched';
    // // Future.delayed(new Duration(seconds: 5));
    // notifyListeners();
    // return null;
    
  }
  void play(uri, index, allsongs) async {
     Duration duration;
     Duration position;
    // await stop();
    // print('status $currentStatus');
    print('songs to play $allSongs');
    audioPlayer = new MusicFinder();
    // print('from scoped model index $index');
    final result = await audioPlayer.play(uri);
    _currentTrackIndex = index;
    _isPlaying.add('playing');
    audioPlayer.setDurationHandler((Duration d) {
      duration = d;
      _trackDuration = duration;
        print('duration $duration');
    });

    //   audioPlayer.setPositionHandler((Duration d) {
    //     position = d;
    //     _isPlaying.add('playing');
    //     _trackPosition.add(position);
    //       print('position $position');
    //   });
    notifyListeners();
    return;
  }

  setTrackDuration(duration) {
     _trackDuration = duration;
     notifyListeners();
  }

  handlePlayBack(uri, index, allsongs) {
    print('handling playback');
    if (_playBackMode == 0) {
      // do nothing
      stop();
      notifyListeners();
      // return;
    } else if (_playBackMode == 1) {
      // repeat same ong
      play(uri, index, allsongs);
    } else {
      skip(index, allsongs);
    }
  }

   skip(currentIndex, allsongs) async {
    Duration duration;
    audioPlayer = new MusicFinder();
    print('current index $currentIndex');
    // check shuffle mode
    if (_shuffle == 1) {
      _currentTrackIndex= random.nextInt(allsongs.length);
      final newUri = allsongs[_currentTrackIndex].uri;
      final result = await audioPlayer.play(newUri);
      print('result from play $result');
      // playerState = PlayerState.playing;
      _isPlaying.add('playing');
      audioPlayer.setDurationHandler((Duration d) {
        duration = d;
        _trackDuration = duration;
        print('duration $duration');
      });

      notifyListeners();
    } else {
      currentIndex == allsongs.length - 1 ? _currentTrackIndex = 0 : _currentTrackIndex = currentIndex + 1;
      // print('new index $_currentTrackIndex');
      // print('songs lsiting $allsongs');
      final newUri = allsongs[_currentTrackIndex].uri;
      final result = await audioPlayer.play(newUri);
      print('result from play $result');
      // playerState = PlayerState.playing;
      _isPlaying.add('playing');
      //  Future.delayed(new Duration(seconds: 5));
      //  isPlaying.listen((dynamic isPlaying) {
      //    print('after delay $isPlaying');
      //  });
      audioPlayer.setDurationHandler((Duration d) {
        duration = d;
        _trackDuration = duration;
        print('duration $duration');
      });
      notifyListeners();
    }

    _songChangeCount.add(_count+1);
  }

  previous(currentIndex, allsongs) async {
    Duration duration;
    audioPlayer = new MusicFinder();
    print('current index ${allsongs.length - 1}');
    currentIndex == 0 ? _currentTrackIndex = allsongs.length - 1 : _currentTrackIndex = currentIndex - 1;
    _currentTrackIndex = currentIndex - 1;
    // print('new index $_currentTrackIndex');
    // print('songs lsiting $allsongs');
    final newUri = allsongs[_currentTrackIndex].uri;
    final result = await audioPlayer.play(newUri);
    print('result from play $result');
    // playerState = PlayerState.playing;
    _isPlaying.add('playing');
    audioPlayer.setDurationHandler((Duration d) {
      duration = d;
        _trackDuration = duration;
        print('duration $duration');
      });
    //  Future.delayed(new Duration(seconds: 5));
    //  isPlaying.listen((dynamic isPlaying) {
    //    print('after delay $isPlaying');
    //  });
    notifyListeners();
  }
  pause() async {
    audioPlayer = new MusicFinder();
    await audioPlayer.pause();
    //  playerState = PlayerState.paused;
      _isPlaying.add('paused');
     notifyListeners();
  }
  stop() async {
    await audioPlayer.stop();
    _isPlaying.add('stopped');
  }

  seek() async {
    await audioPlayer.seek(5.0);
    
  }

  Future initializeApp() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final dynamic playBackMode = await prefs.getInt('playBackMode');
    print('playback mode $playBackMode');
    playBackMode == null ? _playBackMode = 0 : _playBackMode = playBackMode;
    final dynamic shuffle = prefs.getInt('shuffle');
    shuffle == null ? _shuffle = 0 : _shuffle = shuffle;
    print('app init');
  }

  setPlayBackMode(mode) async {
     final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt('playBackMode', mode);
      _playBackMode = mode;
      notifyListeners();
  }

  setShuffle(mode) async {
     final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt('shuffle', mode);
      _shuffle = mode;
      notifyListeners();
  }

  sortAlbums(songs) {
      List <Song> newSongAlbum = [];
      songs.forEach((Song songAlbum) {
        print('song album ${songAlbum.album}');
        newSongAlbum.contains(songAlbum.album) == false ? newSongAlbum.add(songAlbum) : print('album already exist'); 
      });
      _album =newSongAlbum;
      print('song albums ${_album.length}');
  }
}