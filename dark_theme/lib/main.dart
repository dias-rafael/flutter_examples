import 'package:flutter/material.dart';
import 'package:dark_theme/tools/notifier.dart';
import 'package:dark_theme/tools/constants.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:dark_theme/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); 
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]).then((_) {
    SharedPreferences.getInstance().then((prefs) {
      var darkModeOn = prefs.getBool('darkMode') ?? true;
      runApp(
        ChangeNotifierProvider<ThemeNotifier>(
          builder: (_) => ThemeNotifier(darkModeOn ? darkTheme : lightTheme),
          child: MyApp(),
        ),
      );
    });
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
      title: 'Dark Theme',
      debugShowCheckedModeBanner: false,
      theme: themeNotifier.getTheme(),
      home: HomePage(),
    );
  }
}