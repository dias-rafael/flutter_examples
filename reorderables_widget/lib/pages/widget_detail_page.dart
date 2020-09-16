import 'package:flutter/material.dart';
import 'package:reorderables_widget/models/home_widgets/widgets_info_model.dart';

class WidgetDetailPage extends StatelessWidget {
  final WidgetsInfoModel model;
  const WidgetDetailPage({Key key, this.model}) : super(key: key);

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
          ],
        ),
      ),
    );
  }
}