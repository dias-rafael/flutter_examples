import 'dart:math' as math;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:reorderables/reorderables.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/home_widgets/widgets_info_model.dart';

class NestedWrapExample extends StatefulWidget {
  NestedWrapExample({
    Key key,
    this.depth = 0,
    this.valuePrefix = '',
    this.color,
    this.title,
    this.order,
  }) : super(key: key);
  final int depth;
  final String valuePrefix;
  final Color color;
  final String title;
  final int order;

  @override
  State createState() => _NestedWrapExampleState();
}

class _NestedWrapExampleState extends State<NestedWrapExample> {
  SharedPreferences prefs;

  List<WidgetsInfoModel> models;
  @override
  void initState() {
    // default models list
    models = [
      WidgetsInfoModel(index: 0, order: 0, title: '00', subtitle: 'GLICOSE DAY', widthFactor: 3, height: 100),      
      WidgetsInfoModel(index: 1, order: 0, title: '30', subtitle: 'GLICOSE WEEK', widthFactor: 1.5, height: 100),      
      WidgetsInfoModel(index: 2, order: 1, title: '100', subtitle: 'GLICOSE MONTH', widthFactor: 1, height: 100),          
      WidgetsInfoModel(index: 3, order: 2, title: '00', subtitle: 'GLICOSE DAY', widthFactor: 2, height: 50),      
      WidgetsInfoModel(index: 4, order: 2, title: '30', subtitle: 'GLICOSE WEEK', widthFactor: 2, height: 50),     
      /* 
      WidgetsInfoModel(index: 0, order: 3, title: '100', subtitle: 'GLICOSE MONTH', widthFactor: 1, height: 50),         
      WidgetsInfoModel(index: 0, order: 4, title: '400', subtitle: 'GLICOSE MONTH', widthFactor: 3, height: 50),         
      WidgetsInfoModel(index: 1, order: 4, title: '500', subtitle: 'GLICOSE MONTH', widthFactor: 3, height: 50),         
      WidgetsInfoModel(index: 2, order: 4, title: '600', subtitle: 'GLICOSE MONTH', widthFactor: 3, height: 50),     */    
    ];
    config();
    super.initState();
  }

  void config() async {
    // Here we reset the default model based on  saved order
    await SharedPreferences.getInstance().then((pref) {
      prefs = pref;
      List<String> lst = pref.getStringList('orderList');

      List<WidgetsInfoModel> list = [];
      if (lst != null && lst.isNotEmpty) {
        list = lst
            .map(
              (String indx) => models
                  //.where((WidgetsInfoModel item) => int.parse(indx) == item.index+item.order)
                  .where((WidgetsInfoModel item) => indx == (item.index.toString() + '-' + item.order.toString()))
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
    models.insert(newIndex, row);
    setState(() {
      print(models.map((m) => (m.index.toString() + '-' + widget.order.toString())).toList().toString());
      prefs.setStringList(
          //'orderList', models.map((m) => m.index.toString()).toList());
          'orderList', models.map((m) => (m.index.toString() + '-' + m.order.toString())).toList());
    });    
    print("XXXXXX: "+ prefs.getStringList('orderList').toString());
  }

  @override
  Widget build(BuildContext context) {
    final cards = <Widget>[];
    var totalCards = 0;
    for (var i = 0; i < models.length; i++) {
      if (models[i].order == widget.order) {
        totalCards++;
      }
    }
    for (var i = 0; i < models.length; i++) {
      if (models[i].order == widget.order) {    
        cards.add(
          Container(
          child: MyCard(
              totalCards: totalCards,
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
    }
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      //margin: EdgeInsets.only(top: 5, bottom: 5),
      color: widget.color,
      child: Column(      
        children: <Widget> [
          widget.title != null ? Text(widget.title) : Container(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ReorderableWrap(
                //spacing: (totalCards > 1) ? 5.0 : 0.0,
                key: Key(widget.order.toString()),
                runSpacing: 0,
                maxMainAxisCount: 5,
                minMainAxisCount: 3,
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                children: cards,
                  /*
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
                  */
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
              )
            ]
          )
        ]
      )
    );
  }
}

// ------------------------ MyCard ----------------------------
class MyCard extends StatelessWidget {
  final WidgetsInfoModel model;
  final void Function() onTap;
  final int totalCards;

  const MyCard({Key key, this.onTap, @required this.model, @required this.totalCards})
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
