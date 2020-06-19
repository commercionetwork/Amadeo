// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dsb_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DsbResult _$DsbResultFromJson(Map<String, dynamic> json) {
  return DsbResult(
    cert: json['cert'] as String,
    hash: json['hash'] as String,
  );
}

Map<String, dynamic> _$DsbResultToJson(DsbResult instance) => <String, dynamic>{
      'cert': instance.cert,
      'hash': instance.hash,
    };
