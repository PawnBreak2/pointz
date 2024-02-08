// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'core_local_db_request_state_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LocalDbRequestState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isError => throw _privateConstructorUsedError;
  dynamic get data => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LocalDbRequestStateCopyWith<LocalDbRequestState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocalDbRequestStateCopyWith<$Res> {
  factory $LocalDbRequestStateCopyWith(
          LocalDbRequestState value, $Res Function(LocalDbRequestState) then) =
      _$LocalDbRequestStateCopyWithImpl<$Res, LocalDbRequestState>;
  @useResult
  $Res call({bool isLoading, bool isError, dynamic data});
}

/// @nodoc
class _$LocalDbRequestStateCopyWithImpl<$Res, $Val extends LocalDbRequestState>
    implements $LocalDbRequestStateCopyWith<$Res> {
  _$LocalDbRequestStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isError = null,
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isError: null == isError
          ? _value.isError
          : isError // ignore: cast_nullable_to_non_nullable
              as bool,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LocalDbRequestStateImplCopyWith<$Res>
    implements $LocalDbRequestStateCopyWith<$Res> {
  factory _$$LocalDbRequestStateImplCopyWith(_$LocalDbRequestStateImpl value,
          $Res Function(_$LocalDbRequestStateImpl) then) =
      __$$LocalDbRequestStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isLoading, bool isError, dynamic data});
}

/// @nodoc
class __$$LocalDbRequestStateImplCopyWithImpl<$Res>
    extends _$LocalDbRequestStateCopyWithImpl<$Res, _$LocalDbRequestStateImpl>
    implements _$$LocalDbRequestStateImplCopyWith<$Res> {
  __$$LocalDbRequestStateImplCopyWithImpl(_$LocalDbRequestStateImpl _value,
      $Res Function(_$LocalDbRequestStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isError = null,
    Object? data = freezed,
  }) {
    return _then(_$LocalDbRequestStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isError: null == isError
          ? _value.isError
          : isError // ignore: cast_nullable_to_non_nullable
              as bool,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

class _$LocalDbRequestStateImpl
    with DiagnosticableTreeMixin
    implements _LocalDbRequestState {
  const _$LocalDbRequestStateImpl(
      {this.isLoading = false, this.isError = false, this.data});

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isError;
  @override
  final dynamic data;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'LocalDbRequestState(isLoading: $isLoading, isError: $isError, data: $data)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'LocalDbRequestState'))
      ..add(DiagnosticsProperty('isLoading', isLoading))
      ..add(DiagnosticsProperty('isError', isError))
      ..add(DiagnosticsProperty('data', data));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocalDbRequestStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isError, isError) || other.isError == isError) &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading, isError,
      const DeepCollectionEquality().hash(data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LocalDbRequestStateImplCopyWith<_$LocalDbRequestStateImpl> get copyWith =>
      __$$LocalDbRequestStateImplCopyWithImpl<_$LocalDbRequestStateImpl>(
          this, _$identity);
}

abstract class _LocalDbRequestState implements LocalDbRequestState {
  const factory _LocalDbRequestState(
      {final bool isLoading,
      final bool isError,
      final dynamic data}) = _$LocalDbRequestStateImpl;

  @override
  bool get isLoading;
  @override
  bool get isError;
  @override
  dynamic get data;
  @override
  @JsonKey(ignore: true)
  _$$LocalDbRequestStateImplCopyWith<_$LocalDbRequestStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
