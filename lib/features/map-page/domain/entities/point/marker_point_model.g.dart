// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'marker_point_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MarkerPointImpl _$$MarkerPointImplFromJson(Map<String, dynamic> json) =>
    _$MarkerPointImpl(
      id: json['id'] as int,
      label: json['label'] as String,
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
    );

Map<String, dynamic> _$$MarkerPointImplToJson(_$MarkerPointImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'lat': instance.lat,
      'lng': instance.lng,
    };
