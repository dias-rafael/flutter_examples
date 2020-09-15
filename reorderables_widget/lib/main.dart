import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:reorderables/reorderables.dart';
import 'package:reorderables_widget/models/home_widgets/widgets_info_model.dart';
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
  Color _color;

  SharedPreferences prefs;

  List<WidgetsInfoModel> models;  

  @override
  void initState() {
    super.initState();
    models = [
      WidgetsInfoModel(index: 0, order: 0, title: '00', subtitle: 'GLICOSE DAY', widthFactor: 3, height: 100),      
      WidgetsInfoModel(index: 1, order: 0, title: '30', subtitle: 'GLICOSE WEEK', widthFactor: 1.5, height: 100),      
      WidgetsInfoModel(index: 2, order: 1, title: '100', subtitle: 'GLICOSE MONTH', widthFactor: 1, height: 100),          
      WidgetsInfoModel(index: 3, order: 2, title: '00', subtitle: 'GLICOSE DAY', widthFactor: 2, height: 50),      
      WidgetsInfoModel(index: 4, order: 2, title: '30', subtitle: 'GLICOSE WEEK', widthFactor: 2, height: 50),           
      WidgetsInfoModel(index: 5, order: 3, title: '400', subtitle: 'GLICOSE MONTH', widthFactor: 3, height: 50),         
      WidgetsInfoModel(index: 6, order: 3, title: '500', subtitle: 'GLICOSE MONTH', widthFactor: 3, height: 50),         
      WidgetsInfoModel(index: 7, order: 3, title: '600', subtitle: 'GLICOSE MONTH', widthFactor: 3, height: 50), 
    ];    
    _color = Colors.black;
    config();
  }

  void config() async {
    // Here we reset the default model based on  saved order
    await SharedPreferences.getInstance().then((pref) {
      prefs = pref;
      List<String> lst = pref.getStringList('indexList');

      List<WidgetsInfoModel> list = [];
      if (lst != null && lst.isNotEmpty) {
        list = lst
            .map(
              (String indx) => models
                  .where((WidgetsInfoModel item) => int.parse(indx) == item.index)
                  .first,
            )
            .toList();
        models = list;
      }
      setState(() {});
    });
  }

  void _onReorder(int oldIndex, int newIndex) async {
    WidgetsInfoModel row = models.removeAt(oldIndex);
    print(row);
    models.insert(newIndex, row);
    print(newIndex);
    print(models);
    setState(() {
      prefs.setStringList(
          'indexList', models.map((m) => m.index.toString()).toList());
    });
  }

  @override
  Widget build(BuildContext context) {
    final groups = <Widget>[];
    for (var i = 0; i < models.length; i++) {
      groups.add(
        Container(
          child: MyCard(
              model: models[i],
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => FakePage(model: models[i]),
                ),
              ),
            ),
          )
      );
    }

    var wrap = ReorderableWrap(
      spacing: 0.0,
      runSpacing: 10.0,
      //padding: const EdgeInsets.all(4),
      children: groups,
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
      }
    );

    var column = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 40,
        ),
        Container(
          margin: EdgeInsets.only(bottom: 50, left: 20.0, right: 20.0),
          width: 135,
          //height: 45,
          child: Image(
            image: AssetImage("assets/ui/logo.png"),
            fit: BoxFit.contain,
          ),        
        ),
        Container(
          child: AutoSizeText(
            "DATA VIEWER",
            maxLines: 1,
            minFontSize: 35,
            maxFontSize: 40,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.orange[600],
              fontWeight: FontWeight.bold,
            ),
          )
        ),    
        Container(
          height: 20,
        ),           
        wrap,
        Container(
          height: 30,
        ),        
        Container(
          child: AutoSizeText(
            "START HERE",
            maxLines: 1,
            minFontSize: 25,
            maxFontSize: 30,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.orange[600],
              fontWeight: FontWeight.bold,
            ),
          )
        ),   
        Container(
          height: 30,
        ),
        Icon(Icons.add, color: Colors.white),
        Container(
          height: 30,
        ),        
      ]
    );

    return Container(
      //width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: _color,
      //padding: EdgeInsets.only(top: 5, bottom: 5),
      child: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: column, 
        ),
      ),
    );
  }
}

// ------------------------ MyCard ----------------------------
class MyCard extends StatelessWidget {
  final WidgetsInfoModel model;
  final void Function() onTap;
  final int totalCards;

  const MyCard({Key key, this.onTap, @required this.model, this.totalCards})
      : assert(model != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width-20;
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
      //width: (totalCards > 1) ? ((width - ((totalCards-1) * 10))/model.widthFactor) : width/model.widthFactor,
      width: width/model.widthFactor - 8,
      height: model.height,
      //margin: EdgeInsets.all(5.0),
      child: Column(
       // mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          /*
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
          */ 
          (model.title != null) ? Expanded(
            flex: 3,
            child: Row(
              //mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: AutoSizeText(
                    model.title,
                    maxLines: 1,
                    minFontSize: 20,
                    maxFontSize: 30,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.orange[600],
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                  )
                ),
              ],
            ),
          ) : Container(),
          (model.subtitle != null) ? Expanded(
            flex: 3,
            child: Row(
              //mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: AutoSizeText(
                    model.subtitle,
                    maxLines: 1,
                    minFontSize: 12,
                    maxFontSize: 14,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.orange[600],
                      fontWeight: FontWeight.w500,
                    ),
                    //overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ) : Container(),          
        ],
      ),
    );
  }
}


// ----------------------- FAKE PAGE ---------------------------
class FakePage extends StatelessWidget {
  final WidgetsInfoModel model;
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
            /*
            Padding(
              padding: EdgeInsets.only(top: 24.0),
              child: Icon(
                model.icon.icon,
                size: 70.0,
              ),
            ),
            */
          ],
        ),
      ),
    );
  }
}
