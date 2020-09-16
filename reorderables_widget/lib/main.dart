import 'package:flutter/material.dart';
import 'package:reorderables_widget/pages/home_page.dart';

void main() => runApp(AppEntrypoint());

class AppEntrypoint extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reordable Widget',
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}