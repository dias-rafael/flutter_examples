import 'package:flutter/material.dart';
import 'package:reorderables/reorderables.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: Page(),
          ),
        ),
      ),
    );

class Page extends StatefulWidget {
  const Page({Key key}) : super(key: key);

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Page> {
  SharedPreferences prefs;

  List<Model> models;
  @override
  void initState() {
    // default models list
    models = [
      Model(index: 0, icon: Icon(Icons.people), title: 'Coach'),
      Model(index: 1, icon: Icon(Icons.wb_incandescent), title: 'Victories'),
      Model(index: 2, icon: Icon(Icons.card_giftcard), title: 'Jeux'),
      Model(index: 3, icon: Icon(Icons.wb_sunny), title: 'Sunny'),
      Model(index: 4, icon: Icon(Icons.cloud), title: 'Cloud'),
      Model(index: 5, icon: Icon(Icons.tv), title: 'TV'),
      Model(index: 6, icon: Icon(Icons.place), title: 'Location'),
      Model(index: 8, icon: Icon(Icons.music_note), title: 'Music'),
      // More customization
      Model(
          index: 7,
          icon: Icon(Icons.event_available, color: Color(0xffff9a7b)),
          title: 'Planning'),
    ];
    config();
    super.initState();
  }

  void config() async {
    // Here we reset the default model based on  saved order
    await SharedPreferences.getInstance().then((pref) {
      prefs = pref;
      List<String> lst = pref.getStringList('indexList');

      List<Model> list = [];
      if (lst != null && lst.isNotEmpty) {
        list = lst
            .map(
              (String indx) => models
                  .where((Model item) => int.parse(indx) == item.index)
                  .first,
            )
            .toList();
        models = list;
      }
      setState(() {});
    });
  }

  void _onReorder(int oldIndex, int newIndex) async {
    Model row = models.removeAt(oldIndex);
    models.insert(newIndex, row);
    setState(() {
      prefs.setStringList(
          'indexList', models.map((m) => m.index.toString()).toList());
    });
  }

  @override
  Widget build(BuildContext context) {
    return ReorderableWrap(
        spacing: 0.0,
        runSpacing: 0,
        maxMainAxisCount: 5,
        minMainAxisCount: 3,
        padding: const EdgeInsets.all(5),
        children: <Widget>[
          MyCard(
            model: models[0],
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => FakePage(model: models[0]),
              ),
            ),
          ),
          MyCard(
            model: models[1],
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => FakePage(model: models[1]),
              ),
            ),
          ),
          MyCard(
            model: models[2],
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => FakePage(model: models[2]),
              ),
            ),
          ),
          MyCard(
            model: models[3],
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => FakePage(model: models[3]),
              ),
            ),
          ),
          MyCard(
            model: models[4],
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => FakePage(model: models[4]),
              ),
            ),
          ),
          MyCard(
            model: models[5],
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => FakePage(model: models[5]),
              ),
            ),
          ),
          MyCard(
            model: models[6],
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => FakePage(model: models[6]),
              ),
            ),
          ),
          MyCard(
            model: models[7],
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => FakePage(model: models[7]),
              ),
            ),
          ),
          MyCard(
            model: models[8],
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => FakePage(model: models[8]),
              ),
            ),
          ),
        ],
        onReorder: _onReorder,
        onNoReorder: (int index) {
          //this callback is optional
          debugPrint('${DateTime.now().toString().substring(5, 22)} ' +
              'reorder cancelled. index:$index');
        },
        onReorderStarted: (int index) {
          //this callback is optional
          debugPrint('${DateTime.now().toString().substring(5, 22)} ' +
              'reorder started: index:$index');
        });
  }
}

// ---------------------- Model --------------------------
class Model {
  int index;
  String title;
  Icon icon;
  Model({this.index, this.title, this.icon});

  @override
  String toString() {
    return '$index : $title';
  }
}

// ------------------------ MyCard ----------------------------
class MyCard extends StatelessWidget {
  final Model model;
  final void Function() onTap;

  const MyCard({Key key, this.onTap, @required this.model})
      : assert(model != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 8.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: _child(width),
      ),
    );
  }

  Widget _child(double width) {
    return Container(
      width: width / 4,
      height: width / 3,
      margin: EdgeInsets.all(5.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  model.title,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 15.0,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey.shade400,
                  size: 15.0,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: FittedBox(
                fit: BoxFit.contain,
                child: model.icon,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ----------------------- FAKE PAGE ---------------------------
class FakePage extends StatelessWidget {
  final Model model;
  const FakePage({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'You Clicked on Card : ${model.title}',
              style: TextStyle(fontSize: 20.0),
            ),
            Padding(
              padding: EdgeInsets.only(top: 24.0),
              child: Icon(
                model.icon.icon,
                size: 70.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}




/*

import 'package:flutter/material.dart';

//import './table_example.dart';
//import './wrap_example.dart';
import './nested_wrap_example.dart';
//import './column_example1.dart';
//import './column_example2.dart';
//import './row_example.dart';
//import './sliver_example.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reorderables Demo',
      home: MyHomePage(title: 'Reorderables Demo Home Page'),
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
  int _currentIndex = 0;
  final List<Widget> _examples = [
    //TableExample(),
    //WrapExample(),
    NestedWrapExample(),
    //ColumnExample1(),
    //ColumnExample2(),
    //RowExample(),
    //SliverExample(),
  ];
  final _bottomNavigationColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: _examples[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, // this will be set when a new tab is tapped
//        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_on, color: _bottomNavigationColor),
            title: Text('ReroderableTable', maxLines: 2, style: TextStyle(color: _bottomNavigationColor)),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.apps, color: _bottomNavigationColor),
            title: Text('ReroderableWrap', maxLines: 2, style: TextStyle(color: _bottomNavigationColor)),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.view_quilt, color: _bottomNavigationColor),
            title: Text('Nested ReroderableWrap', maxLines: 3, style: TextStyle(color: _bottomNavigationColor)),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_vert, color: _bottomNavigationColor),
            title: Text('ReroderableColumn 1', maxLines: 2, style: TextStyle(color: _bottomNavigationColor))
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_vert, color: _bottomNavigationColor),
            title: Text('ReroderableColumn 2', maxLines: 2, style: TextStyle(color: _bottomNavigationColor))
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz, color: _bottomNavigationColor),
            title: Text('ReroderableRow', maxLines: 2, style: TextStyle(color: _bottomNavigationColor))
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_view_day, color: _bottomNavigationColor),
            title: Text('ReroderableSliverList', maxLines: 2, style: TextStyle(color: _bottomNavigationColor))
          ),
        ],
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

*/