import 'package:flutter/material.dart';
import 'package:flute_music_player/flute_music_player.dart';
import '../theme-data.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped-models/main.dart';
// import 'package:web_socket_channel/web_socket_channel.dart';
// import 'package:web_socket_channel/html.dart';
// import 'package:web_socket_channel/io.dart';
/// import 'package:adonis_websok/html.dart';
// import 'package:adonis_websok/io.dart';

// widget
import '../widgets/media-item.dart';
import '../widgets/side-drawer.dart';
import '../screens/current-track.dart';
import '../widgets/avatar-image-provider.dart';
import '../widgets/playlist.dart';
import '../widgets/album.dart';
// import '../widgets/search-input.dart';

class ExampleMedia extends StatefulWidget {
  final MainModel model;
  ExampleMedia(this.model);
  @override
    State<StatefulWidget> createState() {
    return _ExampleMediaState();
  }
  // _ExampleMediaState createState() => new _ExampleMediaState();
}

class _ExampleMediaState extends State<ExampleMedia> with SingleTickerProviderStateMixin{
  // search
  ScrollController scrollController;
  TextEditingController controller = new TextEditingController();
  String filter;
  TabController tabController;

  final MainModel _model = MainModel();
  dynamic _isPlaying = 'stopped';
  // Duration _trackPosition;
  Function bodyTheming = flexPlayThemeDarkBoxDecoration;
  dynamic bottomAppBarColor = Color(0xff0f0f0f);
  MusicFinder audioPlayer;

  @override
  void initState() {
    // adonisWebsocketConnection();
    widget.model.isPlaying.listen((dynamic isPlaying) {
      setState(() {
        _isPlaying = isPlaying;
        // bodyTheming = flexPlayThemeDarkBoxDecoration;
      });
    });
    
    super.initState();
    audioPlayer = new MusicFinder();
    tabController = new TabController(vsync: this, length: 3);
    fetchSongs();
    // connect to websocket 1
    // var channelName = "room:public";
    // var channel = IOWebSocketChannel.connect("ws://192.168.1.100:3333/adonis-ws");
    // channel.sink.add("connected!");
    // channel.stream.listen((channelName) {
    //   print('listening to channel');
    // });

  }
  // adonisWebsocketConnection() async {
  //   // connect to websocket 2
  //   // For HTML: IOAdonisWebsok -> HTMLAdonisWebsok
  //   final socket = IOAdonisWebsok(host: '192.168.1.100', port: 3333)
  //   ..withJwtToken('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOjEsImlhdCI6MTU4MTE1NTMyNX0.jah-asd03zXmN0ZkiSG25nssxnMj_Ev-Wr5xr-gVtGI');
  //   await socket.connect();
  //    final disponible = await socket.subscribe('room:public');
  //    disponible.on('canvi', (data) => print('canvi: ${data.toString()}'));
  // } 
  fetchSongs() {
    widget.model.fetchSongs();
  }
  Future pause() async {
     _model.pause();
    // setState(() => playerState = PlayerState.paused);
  }
  play(model) async {
    audioPlayer = new MusicFinder();
    if (_isPlaying != 'stopped') {
      print('stop called');
      await _model.stop();
    }  
    _model.play(_model.allSongs[_model.currentTrackIndex].uri, _model.currentTrackIndex, _model.allSongs);
  }
  buildMedia(model) {
    return  model.currentStatus == 'fetched' ? projectWidget(model) : 
    Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
      Center(
        child: Container(
            padding: EdgeInsets.only(top:200),
            child:CircularProgressIndicator(backgroundColor: Color(0xffffa500))
            )      
      ),
      Center(
        child: Container(
            padding: EdgeInsets.only(top:20),
            child:Text('Loading songs',
            style: KontactTheme.titleDarkBg)
            )
        
      )
    ],);
    
  }
  Widget bottomAppBar(model) {
    return  model.currentStatus == 'fetched' ?
      BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 4.0,
        elevation: 20,
        color: bottomAppBarColor,
        child: ListTile(
          leading: CircleAvaterImageProvider(model.allSongs[widget.model.currentTrackIndex].albumArt),
          title: Text(model.allSongs[widget.model.currentTrackIndex].title, style: KontactTheme.titleDarkBg),
          subtitle: Text(model.allSongs[widget.model.currentTrackIndex].artist, style: KontactTheme.subtitleDarkBg),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CurrentTrack(model, _isPlaying)),
            );
          },
        )
      ) :
      Container();
  }

  Widget floatingActionBottom(model) {
    print('is plaaying $_isPlaying');
    if (_isPlaying == 'paused' || _isPlaying == 'stopped') {
      return FloatingActionButton(
        backgroundColor: Color(0xffffa500),
        child: Icon(Icons.play_arrow, color: Colors.white),
        onPressed: () {
          audioPlayer = new MusicFinder();
          widget.model.play(widget.model.allSongs[widget.model.currentTrackIndex].uri, widget.model.currentTrackIndex, widget.model.allSongs);
          // play(model);
        }
      );
    } else {
      return FloatingActionButton(
        backgroundColor: Color(0xffffa500),
        child: Icon(Icons.pause, color: Colors.white),
        onPressed: () {
          widget.model.pause();
        }
      );
    }
  }
  Widget projectWidget(model) {
    return 
      Flexible(
        child: ListView.builder(
          itemCount: model.allSongs.length,
          itemBuilder: (context, index) {
            final project = model.allSongs[index];
            // print('projects $project');
            return filter == null || filter == "" ?
            MediaItem(project, _isPlaying, index, model) : project.title.toLowerCase().contains(filter.toLowerCase()) ?

            MediaItem(project, _isPlaying, index, model)
              // return empty container if it does not contain filter
              : new Container(); 
            // return MediaItem(project, _isPlaying, index, model);
          },
        )
      );
}

  void rebuildAllChildren(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }
    (context as Element).visitChildren(rebuild);
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(builder: (BuildContext context, Widget child, MainModel model) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: bodyTheming(),
      child: Scaffold(
        drawer: SideDrawer(),
        drawerScrimColor: Colors.transparent,
        appBar: AppBar( 
          centerTitle: true,
          // All Songs
          backgroundColor: Colors.transparent,        
          title: Text('FlexPlayer',
            style: KontactTheme.headline
          ) ,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search, color: Colors.white),
              onPressed: () {
                Navigator.pushNamed<bool>(
                  context, '/search'                  
                );
              },
            ),
          ],
          bottom: new TabBar(
            controller: tabController,
            tabs: <Widget>[
            new Tab(child: Text('All Songs', style: KontactTheme.titleDarkBg)),
            new Tab(child: Text('Playlist', style: KontactTheme.titleDarkBg)),
            new Tab(child: Text('Albums', style: KontactTheme.titleDarkBg))
          ],),
          ),
          // tabview
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          floatingActionButton: model.currentStatus == 'fetched' ? floatingActionBottom(model) : Container(),
          bottomNavigationBar: bottomAppBar(model),
        backgroundColor: Colors.transparent,
        body: new TabBarView(
          controller: tabController,
          children: <Widget>[
            Container( 
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.transparent,
              ),        
              child: Container(
                child: Column(children: <Widget>[
                  Container(                           
                    child: buildMedia(model)
                  )
                ],)           
              )   
            ),
            // new Container(child: buildMedia(model)),
            
            FlexPlayList(),
            FlexAlbum(model)
          ],
        )
        // body: Container( 
        //    width: MediaQuery.of(context).size.width,
        //    decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(20),
        //     color: Colors.transparent,
        //   ),
          
        //   child: Container(
        //     // padding: EdgeInsets.all(15), 
        //     child: Column(children: <Widget>[
        //       Container(
                
        //         // child: buildMedia(model)
        //       )
        //     ],)           
        //   )   
        // ),
      )
    );
    });
  }
}
