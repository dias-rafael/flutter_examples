import 'package:flutter/material.dart';
import 'package:reorderwrap/reorder_wrap.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'ReorderWrap'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> _icons = <Widget>[
    Container(
      child: GestureDetector(
        child: Container(height: 90, width: 90, color: Colors.red),
        onTap: () {
          debugPrint("Tap!");
        },
      ),
    ),
    Container(height: 100, width: 100, color: Colors.blue),
    Container(height: 90, width: 90, color: Colors.purple),
    Container(height: 120, width: 90, color: Colors.blueGrey),
    Container(height: 90, width: 90, color: Colors.brown),
    Container(height: 90, width: 150, color: Colors.orange),
    Container(height: 90, width: 90, color: Colors.lime),
    Container(height: 90, width: 90, color: Colors.lightGreen),
    Container(height: 40, width: 90, color: Colors.pink),
    Container(height: 90, width: 90, color: Colors.lightGreenAccent),
    Container(height: 90, width: 30, color: Colors.yellow),
  ];
  List<int> _indexList;

  @override
  void initState() {
    super.initState();
    _indexList = List.generate(_icons.length, (i)=>i);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          ReorderWrap(
            itemHeight: 90,
            itemWidth: MediaQuery.of(context).size.width/2,
            children: _icons,
            reorderCallback: (newIndexList, oldIndex, newIndex){
              setState(() {
                _indexList = newIndexList;
              });
            },
          ),
          Text(_indexList.toString(), 
            style: TextStyle(fontSize: 20)
          )
        ],
      ),
    );
  }
}
