import 'package:grpc_geolocalization/common/grpc_commons.dart';
import 'package:grpc_geolocalization/model/sensor.pb.dart';
import 'package:grpc_geolocalization/model/sensor.pbgrpc.dart';

class SendLocation {
  static Future<SensorInfo> Store() async{
    var client = SensorClient(GrpcClientSingleton().client);
    var _store = StoreEntryRequest.create();
    _store.sensorId = "teste";
    _store.value = "var";
    return await client.store(_store);
  }
}