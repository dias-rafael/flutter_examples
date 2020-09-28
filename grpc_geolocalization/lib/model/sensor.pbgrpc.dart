///
//  Generated code. Do not modify.
//  source: sensor.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'sensor.pb.dart' as $0;
export 'sensor.pb.dart';

class SensorClient extends $grpc.Client {
  static final _$store =
      $grpc.ClientMethod<$0.StoreEntryRequest, $0.SensorInfo>(
          '/sensor_server.Sensor/Store',
          ($0.StoreEntryRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.SensorInfo.fromBuffer(value));

  SensorClient($grpc.ClientChannel channel, {$grpc.CallOptions options})
      : super(channel, options: options);

  $grpc.ResponseFuture<$0.SensorInfo> store($0.StoreEntryRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(_$store, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }
}

abstract class SensorServiceBase extends $grpc.Service {
  $core.String get $name => 'sensor_server.Sensor';

  SensorServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.StoreEntryRequest, $0.SensorInfo>(
        'Store',
        store_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.StoreEntryRequest.fromBuffer(value),
        ($0.SensorInfo value) => value.writeToBuffer()));
  }

  $async.Future<$0.SensorInfo> store_Pre($grpc.ServiceCall call,
      $async.Future<$0.StoreEntryRequest> request) async {
    return store(call, await request);
  }

  $async.Future<$0.SensorInfo> store(
      $grpc.ServiceCall call, $0.StoreEntryRequest request);
}
