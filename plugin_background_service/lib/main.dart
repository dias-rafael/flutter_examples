import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    PermissionHandler().requestPermissions(
        [PermissionGroup.location, PermissionGroup.locationAlways, PermissionGroup.locationWhenInUse]);
  }

  static const platform = const MethodChannel('backgroundServices');
  String _batteryLevel = 'Unknown battery level.';
  String _geoLocation = 'Unknown location.';

  Future<void> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  Future<void> _getGeoLocation() async {
    String geoLocation;
    try {
      final String result = await platform.invokeMethod('getGeoLocation');
      geoLocation = 'Last Location: $result.';
    } on PlatformException catch (e) {
      geoLocation = "Failed to get location: '${e.message}'.";
    }

    setState(() {
      _geoLocation = geoLocation;
    });
  }  

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            RaisedButton(
              child: Text('Get Battery Level'),
              onPressed: _getBatteryLevel,
            ),
            Text(_batteryLevel),
            RaisedButton(
              child: Text('Get Location'),
              onPressed: _getGeoLocation,
            ),
            Text(_geoLocation),            
          ],
        ),
      ),
    );
  }
}
