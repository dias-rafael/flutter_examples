import 'package:flutter/widgets.dart';

class WidgetsInfoModel {
  int index;
  int order;
  String title;
  String subtitle;
  Icon icon;
  double widthFactor;
  double heightFactor;

  WidgetsInfoModel({this.index, this.order, this.title, this.subtitle, this.icon, this.widthFactor, this.heightFactor});

  @override
  String toString() {
    return '$index : $order : $title';
  }
}