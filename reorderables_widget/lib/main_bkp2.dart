import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:reorderables/reorderables.dart';
import 'package:reorderables_widget/models/home_widgets/widgets_data_wrapper_model.dart';
import 'package:reorderables_widget/nested_wrap_example.dart';
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

  List<WidgetsDataWrapperModel> models;  

  @override
  void initState() {
    super.initState();
    models = [
      WidgetsDataWrapperModel(index: 0, title: 'GROUP0', color: Colors.black),//Colors.grey[50]),      
      WidgetsDataWrapperModel(index: 1, title: 'GROUP1', color: Colors.black),//Colors.grey[600]),   
      WidgetsDataWrapperModel(index: 2, title: 'GROUP2', color: Colors.black),//Colors.grey[50]),   
      WidgetsDataWrapperModel(index: 3, title: 'GROUP3', color: Colors.black),//Colors.grey[600]),   
    ];    
    _color = Colors.black;
    config();
  }

  void config() async {
    // Here we reset the default model based on  saved order
    await SharedPreferences.getInstance().then((pref) {
      prefs = pref;
      List<String> lst = pref.getStringList('indexList');

      List<WidgetsDataWrapperModel> list = [];
      if (lst != null && lst.isNotEmpty) {
        list = lst
            .map(
              (String indx) => models
                  .where((WidgetsDataWrapperModel item) => int.parse(indx) == item.index)
                  .first,
            )
            .toList();
        models = list;
      }
      setState(() {});
    });
  }

  void _onReorder(int oldIndex, int newIndex) async {
    WidgetsDataWrapperModel row = models.removeAt(oldIndex);
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
        NestedWrapExample(order: models[i].index, color: models[i].color, title: models[i].title),
      );
    }

    var wrap = ReorderableWrap(
      spacing: 0.0,
      runSpacing: 0.0,
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