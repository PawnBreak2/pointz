// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'marker_point_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MarkerPointImpl _$$MarkerPointImplFromJson(Map<String, dynamic> json) =>
    _$MarkerPointImpl(
      id: json['id'] as int?,
      label: json['label'] as String,
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
    );

Map<String, dynamic> _$$MarkerPointImplToJson(_$MarkerPointImpl instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['label'] = instance.label;
  val['lat'] = instance.lat;
  val['lng'] = instance.lng;
  return val;
}
