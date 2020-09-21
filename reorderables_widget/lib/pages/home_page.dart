import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reorderables/reorderables.dart';
import 'package:reorderables_widget/models/home_widgets/widgets_info_model.dart';
import 'package:reorderables_widget/pages/widget_detail_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //String apiLoadingText = Localization().text('FETCHING_USER') + "...";
  //bool apiLoaded = false;

  //UserInfoWrapperModel userInfo;

  /*
  Future<dynamic> initializeApiProviderWrapper() async {
    await ApiProviderWrapper().init(context, onErrorCallback: () {});
  }
  */

  SharedPreferences prefs;
  List<WidgetsInfoModel> homeWidgets;  
  Widget activeWidget;
  int activeIndexWidget;
  bool tapped;
  List<Widget> groups;

  @override
  void initState() {
    super.initState();
    init();  
    loadSavedOrders();
    tapped = false;
  }

  void init() {
    homeWidgets = [
      WidgetsInfoModel(index: 0, order: 0, title: '00', subtitle: 'GLICOSE DAY', widthFactor: 3, heightFactor: 2),      
      WidgetsInfoModel(index: 1, order: 0, title: '30', subtitle: 'GLICOSE WEEK', widthFactor: 1.5, heightFactor: 2),      
      WidgetsInfoModel(index: 2, order: 1, title: '100', subtitle: 'GLICOSE MONTH', widthFactor: 1, heightFactor: 2),          
      WidgetsInfoModel(index: 3, order: 2, title: '00', subtitle: 'GLICOSE DAY', widthFactor: 2, heightFactor: 1.5),      
      WidgetsInfoModel(index: 4, order: 2, title: '30', subtitle: 'GLICOSE WEEK', widthFactor: 2, heightFactor: 1.5),           
      WidgetsInfoModel(index: 5, order: 3, title: '400', subtitle: 'GLICOSE MONTH', widthFactor: 3, heightFactor: 1),         
      WidgetsInfoModel(index: 6, order: 3, title: '500', subtitle: 'GLICOSE MONTH', widthFactor: 3, heightFactor: 1),         
      WidgetsInfoModel(index: 7, order: 3, title: '600', subtitle: 'GLICOSE MONTH', widthFactor: 3, heightFactor: 1), 
    ];   
  }  

  void loadSavedOrders() async {
    // Here we reset the default model based on  saved order
    await SharedPreferences.getInstance().then((pref) {
      prefs = pref;
      var lst = pref.getStringList('indexList');

      var list = <WidgetsInfoModel>[];
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
    var row = homeWidgets.removeAt(oldIndex);
    homeWidgets.insert(newIndex, row);
    setState(() {
      prefs.setStringList(
          'indexList', homeWidgets.map((m) => m.index.toString()).toList());
    });
  }

  /*
  Future awaitInitialize() async {
    await initializeApiProviderWrapper().then((result) async {
      await ApiProviderWrapper()
          .request<UserInfoWrapperModel>(ResourceEnumerate.USER_LOGIN, RequestType.GET)
          .then((response) {
        if (userInfo == null) {
          setState(() {
            userInfo = response;
            apiLoaded = true;
          });
        }
      });
    });
  }
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: true,
      body: SafeArea(
        child: Stack(
          children: <Widget> [            
            Container(
              height: MediaQuery.of(context).size.height,
              color: Colors.black,
              child: SingleChildScrollView(
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 10, right: 10),
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
            ),
            tapped ? GestureDetector(
              onTap: () {
                setState(() {
                  tapped = false;
                });
              },
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                )
              )
            ) : Container(),
            tapped ? Positioned(
              top: 0,
              left: 0,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: resizeWidget(200, 110, activeWidget)
            ) : Container(),            
          ]
        )
      )
    );     
    /*
    return Loading(
      waitFor: awaitInitialize(),
      backgroundColor: Colors.black54,
      color: Colors.white,
      child: Center(
        child: Column(
          children: <Widget>[
            Container(height: 50),
            !apiLoaded ? Text(apiLoadingText, style: TextStyle(fontSize: 20)) : showUserInfo()
          ],
        ),
      ),
    );
    */ 
  }

  Widget resizeWidget(double _width, double _height, Widget _widget) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _widget,
        Container (
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.grey[300], width: 1.0),
            color: Colors.grey[300]
          ),
          width: _width,
          padding: EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  resizeOptions(1, 1, 3, 1),
                  resizeOptions(2, 1, 2, 1),
                  resizeOptions(3, 1, 1, 1),
                ],
              ),
              Container(height: 1, color: Colors.grey[400], margin: EdgeInsets.only(top: 10, bottom: 10, left: 10),),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  resizeOptions(1, 2, 3, 2),
                  resizeOptions(2, 2, 2, 2),
                  resizeOptions(3, 2, 1, 2),                         
                ],
              ),         
              Container(height: 1, color: Colors.grey[400], margin: EdgeInsets.only(top: 10, bottom: 10, left: 10),),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  resizeOptions(1, 3, 3, 3),
                  resizeOptions(2, 3, 2, 3),
                  resizeOptions(3, 3, 1, 3),                                          
                ],
              ),     
              Container(height: 1, color: Colors.grey[400], margin: EdgeInsets.only(top: 10, bottom: 10, left: 10),),
              Container(
                margin: EdgeInsets.only(left: 40, right: 30),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          tapped = false;
                        });
                      },
                      child: Icon(
                        Icons.cancel, 
                        color: Colors.red,
                        size: 28
                      ),  
                    ),  
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          homeWidgets.removeAt(activeIndexWidget);
                          prefs.setStringList('indexList', homeWidgets.map((m) => m.index.toString()).toList());   
                          tapped = false;
                        });
                      },
                      child: Icon(
                        Icons.delete, 
                        color: Colors.grey,
                        size: 30
                      ),
                    )                                                    
                  ],
                ),    
              )                                   
            ]
          )
        )
      ]
    );
  }

  Widget resizeOptions(int _column, int _row, double _widthFactor, double _heightFactor) {
    var _columnsGrid = <Widget>[];
    var _rowsGrid = <Widget>[];

    for (var c = 1; c <= _column; c++) {
      _columnsGrid.add(
        Icon(
          Icons.check_box_outline_blank, 
          color: Colors.black,
          size: 12
        ),
      );
    }

    for (var r = 1; r <= _row; r++) {
      _rowsGrid.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.center, 
          children: _columnsGrid
        )
      );
    }

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState((){
            tapped = false;
            var row = homeWidgets.removeAt(activeIndexWidget);             
            row.widthFactor = _widthFactor;
            row.heightFactor = _heightFactor;
            homeWidgets.insert(activeIndexWidget, row);     
            prefs.setStringList('indexList', homeWidgets.map((m) => m.index.toString()).toList());   
          });
        },
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [Column(children: _rowsGrid)],
          ),
          width: 60,
          alignment: Alignment.centerRight, 
          margin: EdgeInsets.all(5),
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
            image: AssetImage("PUT_YOUR_LOGO_HERE"),
            fit: BoxFit.contain,
          ),        
        ),
        */
        Container(
          margin: EdgeInsets.only(bottom: 20),
          child: AutoSizeText(
            'DATA VIEWER',
            maxLines: 1,
            minFontSize: 35,
            maxFontSize: 40,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.orange,
              fontWeight: FontWeight.bold,
            ),
          )
        )
      ]
    );   
  }

  Widget widgets() {
    groups = [];
    for (var i = 0; i < homeWidgets.length; i++) {
      groups.add(
        cards(
          model: homeWidgets[i],
          callbackTap: (value) {
            setState(() {
              activeWidget = groups.firstWhere((element) => element.key.toString() == value.toString());
              activeIndexWidget = groups.indexWhere((element) => element.key == value);
              tapped = true;                    
            });           
          },
          navigation:() {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => WidgetDetailPage(model: homeWidgets[i]),
              ),
            );
          }
        ),
      );
    }  

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [      
        ReorderableWrap(
          alignment: WrapAlignment.spaceEvenly,
          spacing: 8.0,
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
          margin: EdgeInsets.only(top: 30, bottom: 20),
          child: AutoSizeText(
            'START HERE',
            maxLines: 1,
            minFontSize: 25,
            maxFontSize: 30,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.orange,
              fontWeight: FontWeight.bold,
            ),
          )
        ),
        Container(
          margin: EdgeInsets.only(bottom: 30),
          width: 54,
          height: 54,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.0),
            border: Border.all(color: Colors.white, width: 1.0),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50.0),         
            child: Icon(
              Icons.add, 
              color: Colors.white,
              size: 40
            ),
          )
        )
      ]
    ); 
  }

  Widget cards({WidgetsInfoModel model, Function(Key) callbackTap, Function navigation}) {
    var _key = Key('K' + model.index.toString());
    var _widthDefault = (MediaQuery.of(context).size.width - 20) / model.widthFactor - 8;
    var _heightDefault = (50) * model.heightFactor;

    return AnimatedContainer(
      key: _key,
      alignment: Alignment.topCenter,
      duration: Duration(milliseconds: 500),
      width: _widthDefault,
      height: _heightDefault,      
      child: GestureDetector(
        onTap: () {
          navigation();
        },
        onDoubleTap: () {
          callbackTap(_key);
        },
        child: Card(
          elevation: 8.0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                (model.title != null) ? Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Container( 
                          alignment: Alignment.bottomCenter, 
                          padding: EdgeInsets.only(left: 5, right: 5, top: 5),
                          child: AutoSizeText(
                            model.title,
                            maxLines: 1,
                            minFontSize: 14,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                              fontSize: 50
                            ),
                          )
                        )
                      ),
                    ],
                  ),
                ) : Container(),
                (model.subtitle != null) ? Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          alignment: Alignment.bottomCenter, 
                          padding: EdgeInsets.only(left: 13, right: 13, top: 5, bottom: 5),
                          child: AutoSizeText(
                            model.subtitle,
                            maxLines: 2,
                            minFontSize: 10,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                            ),
                          ),
                        )
                      ),
                    ],
                  ),
                ) : Container(),   
              ],
            ),
          )
        ),
      )
    );
  }
}