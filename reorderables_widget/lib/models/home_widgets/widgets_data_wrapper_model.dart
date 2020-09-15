import 'package:flutter/material.dart';

class WidgetsDataWrapperModel {
  int index;
  String title;
  Color color;
  
  WidgetsDataWrapperModel({this.index, this.title, this.color});

  @override
  String toString() {
    return '$index : $title';
  }
}