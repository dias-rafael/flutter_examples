import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reorderables/reorderables.dart';
import 'package:reorderables_widget/models/home_widgets/widgets_info_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  Color _color;
  SharedPreferences prefs;
  List<WidgetsInfoModel> homeWidgets;  
  bool change;

  @override
  void initState() {
    super.initState();
    init();  
    loadSavedOrders();
    change = false;
    _color = Colors.black;    
  }

  void init() {
    homeWidgets = [
      WidgetsInfoModel(index: 0, order: 0, title: '00', subtitle: 'GLICOSE DAY', widthFactor: 3, height: 50),      
      WidgetsInfoModel(index: 1, order: 1, title: '30', subtitle: 'GLICOSE WEEK', widthFactor: 1.5, height: 50),           
      /*
      WidgetsInfoModel(index: 0, order: 0, title: '00', subtitle: 'GLICOSE DAY', widthFactor: 3, height: 100),      
      WidgetsInfoModel(index: 1, order: 0, title: '30', subtitle: 'GLICOSE WEEK', widthFactor: 1.5, height: 100),      
      WidgetsInfoModel(index: 2, order: 1, title: '100', subtitle: 'GLICOSE MONTH', widthFactor: 1, height: 100),          
      WidgetsInfoModel(index: 3, order: 2, title: '00', subtitle: 'GLICOSE DAY', widthFactor: 2, height: 50),      
      WidgetsInfoModel(index: 4, order: 2, title: '30', subtitle: 'GLICOSE WEEK', widthFactor: 2, height: 50),           
      WidgetsInfoModel(index: 5, order: 3, title: '400', subtitle: 'GLICOSE MONTH', widthFactor: 3, height: 50),         
      WidgetsInfoModel(index: 6, order: 3, title: '500', subtitle: 'GLICOSE MONTH', widthFactor: 3, height: 50),         
      WidgetsInfoModel(index: 7, order: 3, title: '600', subtitle: 'GLICOSE MONTH', widthFactor: 3, height: 50), 
      */
    ];      
  }  

  void loadSavedOrders() async {
    // Here we reset the default model based on  saved order
    await SharedPreferences.getInstance().then((pref) {
      prefs = pref;
      List<String> lst = pref.getStringList('indexList');

      List<WidgetsInfoModel> list = [];
      if (lst != null && lst.isNotEmpty) {
        list = lst
            .map(
              (String indx) => homeWidgets
                  .where((WidgetsInfoModel item) => int.parse(indx) == item.index)
                  .first,
            )
            .toList();
        homeWidgets = list;
      }
      setState(() {});
    });   
  }

  void _onReorder(int oldIndex, int newIndex) async {
    WidgetsInfoModel row = homeWidgets.removeAt(oldIndex);
    homeWidgets.insert(newIndex, row);
    setState(() {
      prefs.setStringList(
          'indexList', homeWidgets.map((m) => m.index.toString()).toList());
    });
  }  

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _color,
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: true,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: _color,
          child: SingleChildScrollView(
            child: Container(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  header(),   
                  widgets(),     
                  footer()       
                ]
              ), 
            ),
          ),
        )
      )
    );    
  }

  Widget header() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        /*
        Container(
          margin: EdgeInsets.only(top: 40, bottom: 50, left: 20.0, right: 20.0),
          width: 135,
          child: Image(
            image: AssetImage("assets/ui/logo.png"),
            fit: BoxFit.contain,
          ),        
        ),
        */
        Container(
          margin: EdgeInsets.only(bottom: 20),
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
        )
      ]
    );   
  }

  Widget widgets() {
    List<Widget> groups = [];
    Widget activeWidget;
    GlobalObjectKey _key;

    for (var i = 0; i < homeWidgets.length; i++) {
      //_key = GlobalObjectKey(models[i].order);
      groups.add(
        cards(
          width: change ? 50 : (MediaQuery.of(context).size.width-20)/homeWidgets[i].widthFactor - 8,
          height: homeWidgets[i].height,
          key: _key,
          model: homeWidgets[i],
          onTap: (GlobalObjectKey _keyWidget) {
            //Widget activeWidget = groups.firstWhere((element) => element.key == Key('C' + _keyWidget.toString()));

            setState(() {
              change = !change;
              activeWidget = groups.firstWhere((element) => element.key == _keyWidget);
            });
            
            /*
              Transform.scale(
                scale: 0.5,
                child: activeWidget,
              );
            */

            print(change);
          },
          /*
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) => WidgetDetailPage(model: homeWidgets[i]),
            ),
          )
          */
        ),
      );
    }  

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [      
        ReorderableWrap(
          spacing: 0.0,
          runSpacing: 10.0,
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
        )
      ]
    );
  }

  Widget footer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [    
        Container(
          margin: EdgeInsets.only(top: 30, bottom: 30),
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
          margin: EdgeInsets.only(bottom: 30),
          child: Icon(
            Icons.add, color: Colors.white
          ),
        )
      ]
    ); 
  }

  Widget cards({WidgetsInfoModel model, Function(GlobalObjectKey) onTap, int totalCards, double width, double height, GlobalObjectKey key}) {
    double height = model.height;
    //double width = (MediaQuery.of(context).size.width-20)/model.widthFactor - 8;

    return GestureDetector(
      onTap: () => onTap(key),
      child: Card(
        elevation: 8.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          //key: Key(model.index.toString()),
          //width: (totalCards > 1) ? ((width - ((totalCards-1) * 10))/model.widthFactor) : width/model.widthFactor,
          width: width,
          height: height,
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
        )
      ),
    );
  }
}
