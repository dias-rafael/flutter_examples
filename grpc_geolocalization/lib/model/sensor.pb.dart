///
//  Generated code. Do not modify.
//  source: sensor.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class SensorInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('SensorInfo', package: const $pb.PackageName('sensor_server'), createEmptyInstance: create)
    ..aOS(1, 'id')
    ..aOS(2, 'lastEntryValue')
    ..hasRequiredFields = false
  ;

  SensorInfo._() : super();
  factory SensorInfo() => create();
  factory SensorInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SensorInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  SensorInfo clone() => SensorInfo()..mergeFromMessage(this);
  SensorInfo copyWith(void Function(SensorInfo) updates) => super.copyWith((message) => updates(message as SensorInfo));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SensorInfo create() => SensorInfo._();
  SensorInfo createEmptyInstance() => create();
  static $pb.PbList<SensorInfo> createRepeated() => $pb.PbList<SensorInfo>();
  @$core.pragma('dart2js:noInline')
  static SensorInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SensorInfo>(create);
  static SensorInfo _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get lastEntryValue => $_getSZ(1);
  @$pb.TagNumber(2)
  set lastEntryValue($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLastEntryValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearLastEntryValue() => clearField(2);
}

class StoreEntryRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('StoreEntryRequest', package: const $pb.PackageName('sensor_server'), createEmptyInstance: create)
    ..aOS(1, 'sensorId')
    ..aOS(2, 'value')
    ..hasRequiredFields = false
  ;

  StoreEntryRequest._() : super();
  factory StoreEntryRequest() => create();
  factory StoreEntryRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory StoreEntryRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  StoreEntryRequest clone() => StoreEntryRequest()..mergeFromMessage(this);
  StoreEntryRequest copyWith(void Function(StoreEntryRequest) updates) => super.copyWith((message) => updates(message as StoreEntryRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static StoreEntryRequest create() => StoreEntryRequest._();
  StoreEntryRequest createEmptyInstance() => create();
  static $pb.PbList<StoreEntryRequest> createRepeated() => $pb.PbList<StoreEntryRequest>();
  @$core.pragma('dart2js:noInline')
  static StoreEntryRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StoreEntryRequest>(create);
  static StoreEntryRequest _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get sensorId => $_getSZ(0);
  @$pb.TagNumber(1)
  set sensorId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSensorId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSensorId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get value => $_getSZ(1);
  @$pb.TagNumber(2)
  set value($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearValue() => clearField(2);
}

