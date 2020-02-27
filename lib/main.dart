import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

// screens
import './screens/login.dart';
import 'package:adonis_websok/io.dart';
import 'package:web_socket_channel/io.dart';
import './screens/contact-home.dart';
import './screens/media.dart';
import './screens/search.dart';
import './screens/new-playlist.dart';
import 'scoped-models/main.dart';

void main() {
 adonisWebsocketConnection(); 
 runApp(MyApp());
}

adonisWebsocketConnection() async {
    // connect to websocket 2
    // For HTML: IOAdonisWebsok -> HTMLAdonisWebsok
    print('trying socket connection');
    // final socket = IOAdonisWebsok(host: '192.168.1.100', port: 3333)
    // ..withJwtToken('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOjEsImlhdCI6MTU4MTE1NTMyNX0.jah-asd03zXmN0ZkiSG25nssxnMj_Ev-Wr5xr-gVtGI');
    // await socket.connect();
    // print('connected to websocket');
    //  final disponible = await socket.subscribe('room:public');
    //  print('subscribed to channel');
    //  disponible.on('canvi', (data) => print('canvi: ${data.toString()}'));

    // connection 1
    var channelName = "room:public";
    var channel = IOWebSocketChannel.connect("ws://192.168.1.100:3333/adonis-ws");
    channel.sink.add("connected!");
    channel.stream.listen((channelName) {
      print('listening to channel');
    });
  } 
class MyApp extends StatefulWidget {
  @override

  State<StatefulWidget> createState() {
    return _MyApp();
  }
}

class _MyApp extends State<MyApp> {
  final MainModel _model = MainModel();
  @override
  initState() {
    setState(() {
      _model.initializeApp();
    });
    super.initState();
  }
  // This widget is the root of your application.
  // @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
      model: _model,
      child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FlexPlay',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.grey,
        brightness: Brightness.light,
        primaryIconTheme: IconThemeData(
          color: Colors.white
        ),
      ),
      routes: {
         '/': (BuildContext context) => ExampleMedia(_model),
        // '/': (BuildContext context) => Auth(),
        '/listing': (BuildContext context) => ContactList(),
        '/media': (BuildContext context) => ExampleMedia(_model),
      },
      onGenerateRoute: (RouteSettings settings) {
        final List<String> pathElements = settings.name.split('/');
        if (pathElements[1] == 'search') {
          return MaterialPageRoute<bool> (
            builder:(BuildContext context) => Search(_model)
          );
        } else if (pathElements[1] == 'new-playlist') {
          return MaterialPageRoute<bool> (
            builder:(BuildContext context) => NewPlaylistForm()
          );
        } 
        },
        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute(
              builder: (BuildContext context) => ContactList());
        },
    ));
  }
}