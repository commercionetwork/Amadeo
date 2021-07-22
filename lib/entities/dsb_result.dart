import 'package:json_annotation/json_annotation.dart';

part 'dsb_result.g.dart';

@JsonSerializable()
class DsbResult {
  final String cert;
  final String hash;

  const DsbResult({required this.cert, required this.hash});

  factory DsbResult.fromJson(Map<String, dynamic> json) =>
      _$DsbResultFromJson(json);

  Map<String, dynamic> toJson() => _$DsbResultToJson(this);

  @override
  String toString() => 'GetReponse { cert: $cert, hash: $hash }';
}
