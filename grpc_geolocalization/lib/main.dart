import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grpc_geolocalization/common/grpc_commons.dart';
import 'package:grpc_geolocalization/converter.dart';
import 'package:grpc_geolocalization/locationWrapper.dart';
import 'package:grpc_geolocalization/services/send_location.dart';
import 'package:location/location.dart';

void main() => runApp(new FlutterGrpcApp());

class FlutterGrpcApp extends StatefulWidget {
  _FlutterGrpcAppState createState() => _FlutterGrpcAppState();
}

class _FlutterGrpcAppState extends State<FlutterGrpcApp> {
  String res;

  LocationWrapper locationWrapper;

  LocationData currentLocation;

  GoogleMapController _controller;
  
  JsonToLocationConverter jsonToLocationConverter = JsonToLocationConverter();

  //final Function(LocationData) onLocationReceivedCallback;
    
  void setup() {
    locationWrapper = LocationWrapper((newLocation) => _sendLocation(newLocation.latitude, newLocation.longitude));
    locationWrapper.prepareLocationMonitoring();
  }

  void gotNewLocation(LocationData newLocationData) {
    setState(() {
      this.currentLocation = newLocationData;
    });
    animateCameraToNewLocation(newLocationData);
  }

  void animateCameraToNewLocation(LocationData newLocation) {
    _controller?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(
            newLocation.latitude,
            newLocation.longitude
        ),
        zoom: GrpcClientSingleton().newZoom
    )));
  }

  @override
  void initState() {
    res = "";
    super.initState();
    setup();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter gRPC Location Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Flutter gRPC Location Demo"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              /*
              FlatButton(
                  onPressed: () async => _sendLocation(1, 2),
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    "Let's say hi!",
                    style: TextStyle(color: Colors.white),
                  )),*/
              res.isNotEmpty ? Text("Server says: $res") : Container(),                         
            ],
          ),
        ),
        /*
        body: GoogleMap(
          initialCameraPosition: CameraPosition(
              target: LatLng(GrpcClientSingleton().defaultLocation.latitude, GrpcClientSingleton().defaultLocation.longitude),
              zoom: GrpcClientSingleton().defaultZoom
          ),
          markers: currentLocation == null ? Set() : [
            Marker(
                markerId: MarkerId(GrpcClientSingleton().defaultMarkerId),
                position: LatLng(currentLocation.latitude, currentLocation.longitude)
            )
          ].toSet(),
          onMapCreated: (GoogleMapController controller) {
            setState(() {
              this._controller = controller;
            });
          },
        ),
        */          
      ),
    );
  }

  Future<void> _sendLocation(double _lat, double _lng) async {
    var response = await SendLocation.Store(_lat, _lng);
    setState(() {
     res = response.toProto3Json().toString();
    });
    print("gRPC Server::GOT A NEW MESSAGE $res");
    LocationData newLocationData = _convertJsonToLocation(res);
    if (newLocationData != null) gotNewLocation(newLocationData);    
  }

  LocationData _convertJsonToLocation(String newLocationJson) {
    try {
      return jsonToLocationConverter.convert(
          newLocationJson);
    } catch (exception) {
      print("Json can't be formatted ${exception.toString()}");
    }
    return null;
  }  
}