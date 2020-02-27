import 'package:flutter/material.dart';
import 'package:flute_music_player/flute_music_player.dart';
import '../theme-data.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped-models/main.dart';

// widget
import '../widgets/media-item.dart';
// import '../widgets/search-input.dart';

// void main() {
//   runApp(new MaterialApp(home: new ExampleMedia(model)));
// }

class Search extends StatefulWidget {
  final MainModel model;
  Search(this.model);
  @override
    State<StatefulWidget> createState() {
    return _SearchState();
  }
  // _SearchState createState() => new _SearchState();
}

class _SearchState extends State<Search> {
  // search
  ScrollController scrollController;
  TextEditingController controller = new TextEditingController();
  String filter;

  final MainModel _model = MainModel();
  dynamic _isPlaying = 'stopped';
  MusicFinder audioPlayer;

  @override
  void initState() {
    _model.isPlaying.listen((dynamic isPlaying) {
      setState(() {
        _isPlaying = isPlaying;
      });
    });
    controller.addListener(() {
      setState(() {
        filter = controller.text;
      });
    });
    super.initState();
    audioPlayer = new MusicFinder();
    // fetchSongs();
  }

  @override
  void dispose() {
    controller.dispose();
    audioPlayer.stop();
    super.dispose();
  }


  fetchSongs() {
    widget.model.fetchSongs();
  }
  Future pause() async {
     _model.pause();
    // setState(() => playerState = PlayerState.paused);
  }

  Widget searchInput() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.75,
            height: 64,
            child: Container(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFF8FAFB),
                  // borderRadius: const BorderRadius.only(
                  //   // bottomRight: Radius.circular(13.0),
                  //   bottomLeft: Radius.circular(13.0),
                  //   topLeft: Radius.circular(13.0),
                  //   // topRight: Radius.circular(13.0),
                  // ),
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: TextFormField(
                          controller: controller,
                          style: TextStyle(
                            fontFamily: 'WorkSans',
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: KontactTheme.nearlyBlue,
                          ),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Search Playlist',
                            border: InputBorder.none,
                            helperStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Color(0xFFB9BABC),
                            ),
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              letterSpacing: 0.2,
                              color: Color(0xFFB9BABC),
                            ),
                          ),
                          onEditingComplete: () {},
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: Icon(Icons.search, color: Color(0xFFB9BABC)),
                    )
                  ],
                ),
              ),
            ),
          ),
          const Expanded(
            child: SizedBox(),
          )
        ],
      ),
    );
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
            },
          )
        );
      // },
      // future: fetchSongs(),
    // );
}



  @override
  Widget build(BuildContext context) {
    // bool status = ScopedModel.of<MainModel>(context, rebuildOnChange: true).currentStatus;
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
      ),
      child: Scaffold(
        appBar: AppBar(
         backgroundColor: Colors.transparent,        
        title: searchInput()),
        backgroundColor: Colors.transparent,
        body: Container( 
           width: MediaQuery.of(context).size.width,
           decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.transparent,
          ),
          
          child: Container(
            padding: EdgeInsets.only(top:25), 
            child: Column(children: <Widget>[
              Container(
                child: projectWidget(model)
              )
            ],)          
          )   
        ),
      )
    );
    });
  }
}
