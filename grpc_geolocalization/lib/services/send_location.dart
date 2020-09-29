import 'package:grpc_geolocalization/common/grpc_commons.dart';
import 'package:grpc_geolocalization/model/sensor.pb.dart';
import 'package:grpc_geolocalization/model/sensor.pbgrpc.dart';

class SendLocation {
  static Future<SensorInfo> Store(double _lat, double _lng) async{
    var client = SensorClient(GrpcClientSingleton().client);
    var _store = StoreEntryRequest.create();
    _store.sensorId = "lat_long";
    _store.value = _lat.toString() + " _ " + _lng.toString();
    return await client.store(_store);
    //await GrpcClientSingleton().client.shutdown();
  }
}