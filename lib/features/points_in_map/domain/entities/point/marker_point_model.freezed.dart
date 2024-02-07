// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'marker_point_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MarkerPoint _$MarkerPointFromJson(Map<String, dynamic> json) {
  return _MarkerPoint.fromJson(json);
}

/// @nodoc
mixin _$MarkerPoint {
  int? get id => throw _privateConstructorUsedError;
  String get label => throw _privateConstructorUsedError;
  double get lat => throw _privateConstructorUsedError;
  double get lng => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MarkerPointCopyWith<MarkerPoint> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MarkerPointCopyWith<$Res> {
  factory $MarkerPointCopyWith(
          MarkerPoint value, $Res Function(MarkerPoint) then) =
      _$MarkerPointCopyWithImpl<$Res, MarkerPoint>;
  @useResult
  $Res call({int? id, String label, double lat, double lng});
}

/// @nodoc
class _$MarkerPointCopyWithImpl<$Res, $Val extends MarkerPoint>
    implements $MarkerPointCopyWith<$Res> {
  _$MarkerPointCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? label = null,
    Object? lat = null,
    Object? lng = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      lat: null == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
      lng: null == lng
          ? _value.lng
          : lng // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MarkerPointImplCopyWith<$Res>
    implements $MarkerPointCopyWith<$Res> {
  factory _$$MarkerPointImplCopyWith(
          _$MarkerPointImpl value, $Res Function(_$MarkerPointImpl) then) =
      __$$MarkerPointImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String label, double lat, double lng});
}

/// @nodoc
class __$$MarkerPointImplCopyWithImpl<$Res>
    extends _$MarkerPointCopyWithImpl<$Res, _$MarkerPointImpl>
    implements _$$MarkerPointImplCopyWith<$Res> {
  __$$MarkerPointImplCopyWithImpl(
      _$MarkerPointImpl _value, $Res Function(_$MarkerPointImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? label = null,
    Object? lat = null,
    Object? lng = null,
  }) {
    return _then(_$MarkerPointImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      lat: null == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
      lng: null == lng
          ? _value.lng
          : lng // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _$MarkerPointImpl with DiagnosticableTreeMixin implements _MarkerPoint {
  const _$MarkerPointImpl(
      {required this.id,
      required this.label,
      required this.lat,
      required this.lng});

  factory _$MarkerPointImpl.fromJson(Map<String, dynamic> json) =>
      _$$MarkerPointImplFromJson(json);

  @override
  final int? id;
  @override
  final String label;
  @override
  final double lat;
  @override
  final double lng;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MarkerPoint(id: $id, label: $label, lat: $lat, lng: $lng)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MarkerPoint'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('label', label))
      ..add(DiagnosticsProperty('lat', lat))
      ..add(DiagnosticsProperty('lng', lng));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MarkerPointImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.lat, lat) || other.lat == lat) &&
            (identical(other.lng, lng) || other.lng == lng));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, label, lat, lng);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MarkerPointImplCopyWith<_$MarkerPointImpl> get copyWith =>
      __$$MarkerPointImplCopyWithImpl<_$MarkerPointImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MarkerPointImplToJson(
      this,
    );
  }
}

abstract class _MarkerPoint implements MarkerPoint {
  const factory _MarkerPoint(
      {required final int? id,
      required final String label,
      required final double lat,
      required final double lng}) = _$MarkerPointImpl;

  factory _MarkerPoint.fromJson(Map<String, dynamic> json) =
      _$MarkerPointImpl.fromJson;

  @override
  int? get id;
  @override
  String get label;
  @override
  double get lat;
  @override
  double get lng;
  @override
  @JsonKey(ignore: true)
  _$$MarkerPointImplCopyWith<_$MarkerPointImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
