import 'package:flutter/material.dart';
// import 'package:scoped_model/scoped_model.dart';
import '../scoped-models/main.dart';
import '../theme-data.dart';

// widget
import '../widgets/AssetImageProvider.dart';

class FlexAlbum extends StatefulWidget {
    final MainModel model;
    FlexAlbum(this.model);
  @override
  State<StatefulWidget> createState() {
    return _FlexAlbum();
  }


}

buildGrid(model) {
  return new GridView.builder(
    itemCount: model.album.length,
    gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
    itemBuilder: (BuildContext context, int index) {
      return Column(children: <Widget>[
        Card(
          borderOnForeground: true,
          elevation: 1.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2.0),
                        
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image(image: new ExactAssetImage("assets/image3.jpg")),
            // model.album[index].albumArt != null ? AssetImageProvider('${model.album[index].albumArt}') : Image(image: new ExactAssetImage("assets/image3.jpg")),
            // AssetImageProvider('${model.album[index].albumArt}'),
            
            Container(
              padding: EdgeInsets.only(top: 4.0, bottom: 2.0, left: 4.0, right: 4.0),
              child: Text('${model.album[index].album}', 
                style: KontactTheme.title,
                overflow: TextOverflow.ellipsis,
              )
            ),
            Container(
               padding: EdgeInsets.only(top: 2.0, bottom: 4.0, left: 4.0, right: 4.0),
              child: Text('${model.album[index].artist}',
                style: KontactTheme.subtitle,
                overflow: TextOverflow.ellipsis,
               )
            )
            
          ],)
        )
      ]);
    }
  );
}
class _FlexAlbum extends State<FlexAlbum> {
  // final MainModel _model = MainModel();
  initState() {
    widget.model.sortAlbums(widget.model.allSongs);
  super.initState();
  }
  Widget build(BuildContext context) {
    return Container(
      padding:EdgeInsets.only(top: 20.0),
      child:  buildGrid(widget.model)
    );
    // return new Container(
    //   child: Center(
    //     child:Text('Music Library', style: KontactTheme.titleDarkBg)
    //     )
    //   );
  }
}