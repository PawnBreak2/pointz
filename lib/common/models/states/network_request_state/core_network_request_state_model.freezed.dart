// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'core_network_request_state_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$NetworkRequestState {
  bool get isLoading =>
      throw _privateConstructorUsedError; // Corrected: Added 'bool' type annotation
  bool get isError => throw _privateConstructorUsedError;
  dynamic get data => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NetworkRequestStateCopyWith<NetworkRequestState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NetworkRequestStateCopyWith<$Res> {
  factory $NetworkRequestStateCopyWith(
          NetworkRequestState value, $Res Function(NetworkRequestState) then) =
      _$NetworkRequestStateCopyWithImpl<$Res, NetworkRequestState>;
  @useResult
  $Res call({bool isLoading, bool isError, dynamic data, String? errorMessage});
}

/// @nodoc
class _$NetworkRequestStateCopyWithImpl<$Res, $Val extends NetworkRequestState>
    implements $NetworkRequestStateCopyWith<$Res> {
  _$NetworkRequestStateCopyWithImpl(this._value, this._then);

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
    Object? errorMessage = freezed,
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
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NetworkRequestStateImplCopyWith<$Res>
    implements $NetworkRequestStateCopyWith<$Res> {
  factory _$$NetworkRequestStateImplCopyWith(_$NetworkRequestStateImpl value,
          $Res Function(_$NetworkRequestStateImpl) then) =
      __$$NetworkRequestStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isLoading, bool isError, dynamic data, String? errorMessage});
}

/// @nodoc
class __$$NetworkRequestStateImplCopyWithImpl<$Res>
    extends _$NetworkRequestStateCopyWithImpl<$Res, _$NetworkRequestStateImpl>
    implements _$$NetworkRequestStateImplCopyWith<$Res> {
  __$$NetworkRequestStateImplCopyWithImpl(_$NetworkRequestStateImpl _value,
      $Res Function(_$NetworkRequestStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isError = null,
    Object? data = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(_$NetworkRequestStateImpl(
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
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$NetworkRequestStateImpl
    with DiagnosticableTreeMixin
    implements _NetworkRequestState {
  const _$NetworkRequestStateImpl(
      {this.isLoading = false,
      this.isError = false,
      this.data,
      this.errorMessage});

  @override
  @JsonKey()
  final bool isLoading;
// Corrected: Added 'bool' type annotation
  @override
  @JsonKey()
  final bool isError;
  @override
  final dynamic data;
  @override
  final String? errorMessage;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'NetworkRequestState(isLoading: $isLoading, isError: $isError, data: $data, errorMessage: $errorMessage)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'NetworkRequestState'))
      ..add(DiagnosticsProperty('isLoading', isLoading))
      ..add(DiagnosticsProperty('isError', isError))
      ..add(DiagnosticsProperty('data', data))
      ..add(DiagnosticsProperty('errorMessage', errorMessage));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NetworkRequestStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isError, isError) || other.isError == isError) &&
            const DeepCollectionEquality().equals(other.data, data) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading, isError,
      const DeepCollectionEquality().hash(data), errorMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NetworkRequestStateImplCopyWith<_$NetworkRequestStateImpl> get copyWith =>
      __$$NetworkRequestStateImplCopyWithImpl<_$NetworkRequestStateImpl>(
          this, _$identity);
}

abstract class _NetworkRequestState implements NetworkRequestState {
  const factory _NetworkRequestState(
      {final bool isLoading,
      final bool isError,
      final dynamic data,
      final String? errorMessage}) = _$NetworkRequestStateImpl;

  @override
  bool get isLoading;
  @override // Corrected: Added 'bool' type annotation
  bool get isError;
  @override
  dynamic get data;
  @override
  String? get errorMessage;
  @override
  @JsonKey(ignore: true)
  _$$NetworkRequestStateImplCopyWith<_$NetworkRequestStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
