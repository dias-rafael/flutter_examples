import 'package:grpc/grpc.dart';
import 'package:location/location.dart';

class GrpcClientSingleton {
  ClientChannel client;
  static final GrpcClientSingleton _singleton =
  new GrpcClientSingleton._internal();

  factory GrpcClientSingleton() => _singleton;

  GrpcClientSingleton._internal() {
    client = ClientChannel("192.168.0.34", // Your IP here, localhost might not work.
        port: 50051,
        options: ChannelOptions(
          //TODO: Change to secure with server certificates
          credentials: ChannelCredentials.insecure(),
          idleTimeout: Duration(minutes: 1),
        ));
  }

  final double defaultZoom = 10.8746;
  final double newZoom = 15.8746;

  final LocationData defaultLocation = new LocationData.fromMap({
    'latitude': -6.1753871,
    'longitude': 106.8249641
  });

  final String defaultMarkerId = "1";  
}