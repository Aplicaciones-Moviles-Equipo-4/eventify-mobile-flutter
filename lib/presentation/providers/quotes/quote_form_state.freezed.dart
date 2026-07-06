// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quote_form_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ServiceItemForm {
  String get description => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  double get unitPrice => throw _privateConstructorUsedError;

  /// Create a copy of ServiceItemForm
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ServiceItemFormCopyWith<ServiceItemForm> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServiceItemFormCopyWith<$Res> {
  factory $ServiceItemFormCopyWith(
          ServiceItemForm value, $Res Function(ServiceItemForm) then) =
      _$ServiceItemFormCopyWithImpl<$Res, ServiceItemForm>;
  @useResult
  $Res call({String description, int quantity, double unitPrice});
}

/// @nodoc
class _$ServiceItemFormCopyWithImpl<$Res, $Val extends ServiceItemForm>
    implements $ServiceItemFormCopyWith<$Res> {
  _$ServiceItemFormCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ServiceItemForm
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = null,
    Object? quantity = null,
    Object? unitPrice = null,
  }) {
    return _then(_value.copyWith(
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      unitPrice: null == unitPrice
          ? _value.unitPrice
          : unitPrice // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ServiceItemFormImplCopyWith<$Res>
    implements $ServiceItemFormCopyWith<$Res> {
  factory _$$ServiceItemFormImplCopyWith(_$ServiceItemFormImpl value,
          $Res Function(_$ServiceItemFormImpl) then) =
      __$$ServiceItemFormImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String description, int quantity, double unitPrice});
}

/// @nodoc
class __$$ServiceItemFormImplCopyWithImpl<$Res>
    extends _$ServiceItemFormCopyWithImpl<$Res, _$ServiceItemFormImpl>
    implements _$$ServiceItemFormImplCopyWith<$Res> {
  __$$ServiceItemFormImplCopyWithImpl(
      _$ServiceItemFormImpl _value, $Res Function(_$ServiceItemFormImpl) _then)
      : super(_value, _then);

  /// Create a copy of ServiceItemForm
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = null,
    Object? quantity = null,
    Object? unitPrice = null,
  }) {
    return _then(_$ServiceItemFormImpl(
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      unitPrice: null == unitPrice
          ? _value.unitPrice
          : unitPrice // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$ServiceItemFormImpl implements _ServiceItemForm {
  const _$ServiceItemFormImpl(
      {required this.description,
      required this.quantity,
      required this.unitPrice});

  @override
  final String description;
  @override
  final int quantity;
  @override
  final double unitPrice;

  @override
  String toString() {
    return 'ServiceItemForm(description: $description, quantity: $quantity, unitPrice: $unitPrice)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServiceItemFormImpl &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.unitPrice, unitPrice) ||
                other.unitPrice == unitPrice));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, description, quantity, unitPrice);

  /// Create a copy of ServiceItemForm
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ServiceItemFormImplCopyWith<_$ServiceItemFormImpl> get copyWith =>
      __$$ServiceItemFormImplCopyWithImpl<_$ServiceItemFormImpl>(
          this, _$identity);
}

abstract class _ServiceItemForm implements ServiceItemForm {
  const factory _ServiceItemForm(
      {required final String description,
      required final int quantity,
      required final double unitPrice}) = _$ServiceItemFormImpl;

  @override
  String get description;
  @override
  int get quantity;
  @override
  double get unitPrice;

  /// Create a copy of ServiceItemForm
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ServiceItemFormImplCopyWith<_$ServiceItemFormImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$QuoteFormState {
  String get title => throw _privateConstructorUsedError;
  String get eventType => throw _privateConstructorUsedError;
  int get guestQuantity => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;
  DateTime get eventDate => throw _privateConstructorUsedError;
  int get organizerId => throw _privateConstructorUsedError;
  List<ServiceItemForm> get serviceItems => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String get additionalDetails => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  QuoteModel? get createdQuote => throw _privateConstructorUsedError;

  /// Create a copy of QuoteFormState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuoteFormStateCopyWith<QuoteFormState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuoteFormStateCopyWith<$Res> {
  factory $QuoteFormStateCopyWith(
          QuoteFormState value, $Res Function(QuoteFormState) then) =
      _$QuoteFormStateCopyWithImpl<$Res, QuoteFormState>;
  @useResult
  $Res call(
      {String title,
      String eventType,
      int guestQuantity,
      String location,
      DateTime eventDate,
      int organizerId,
      List<ServiceItemForm> serviceItems,
      bool isLoading,
      String additionalDetails,
      String? errorMessage,
      QuoteModel? createdQuote});
}

/// @nodoc
class _$QuoteFormStateCopyWithImpl<$Res, $Val extends QuoteFormState>
    implements $QuoteFormStateCopyWith<$Res> {
  _$QuoteFormStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuoteFormState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? eventType = null,
    Object? guestQuantity = null,
    Object? location = null,
    Object? eventDate = null,
    Object? organizerId = null,
    Object? serviceItems = null,
    Object? isLoading = null,
    Object? additionalDetails = null,
    Object? errorMessage = freezed,
    Object? createdQuote = freezed,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      eventType: null == eventType
          ? _value.eventType
          : eventType // ignore: cast_nullable_to_non_nullable
              as String,
      guestQuantity: null == guestQuantity
          ? _value.guestQuantity
          : guestQuantity // ignore: cast_nullable_to_non_nullable
              as int,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      eventDate: null == eventDate
          ? _value.eventDate
          : eventDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      organizerId: null == organizerId
          ? _value.organizerId
          : organizerId // ignore: cast_nullable_to_non_nullable
              as int,
      serviceItems: null == serviceItems
          ? _value.serviceItems
          : serviceItems // ignore: cast_nullable_to_non_nullable
              as List<ServiceItemForm>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      additionalDetails: null == additionalDetails
          ? _value.additionalDetails
          : additionalDetails // ignore: cast_nullable_to_non_nullable
              as String,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      createdQuote: freezed == createdQuote
          ? _value.createdQuote
          : createdQuote // ignore: cast_nullable_to_non_nullable
              as QuoteModel?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$QuoteFormStateImplCopyWith<$Res>
    implements $QuoteFormStateCopyWith<$Res> {
  factory _$$QuoteFormStateImplCopyWith(_$QuoteFormStateImpl value,
          $Res Function(_$QuoteFormStateImpl) then) =
      __$$QuoteFormStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      String eventType,
      int guestQuantity,
      String location,
      DateTime eventDate,
      int organizerId,
      List<ServiceItemForm> serviceItems,
      bool isLoading,
      String additionalDetails,
      String? errorMessage,
      QuoteModel? createdQuote});
}

/// @nodoc
class __$$QuoteFormStateImplCopyWithImpl<$Res>
    extends _$QuoteFormStateCopyWithImpl<$Res, _$QuoteFormStateImpl>
    implements _$$QuoteFormStateImplCopyWith<$Res> {
  __$$QuoteFormStateImplCopyWithImpl(
      _$QuoteFormStateImpl _value, $Res Function(_$QuoteFormStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of QuoteFormState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? eventType = null,
    Object? guestQuantity = null,
    Object? location = null,
    Object? eventDate = null,
    Object? organizerId = null,
    Object? serviceItems = null,
    Object? isLoading = null,
    Object? additionalDetails = null,
    Object? errorMessage = freezed,
    Object? createdQuote = freezed,
  }) {
    return _then(_$QuoteFormStateImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      eventType: null == eventType
          ? _value.eventType
          : eventType // ignore: cast_nullable_to_non_nullable
              as String,
      guestQuantity: null == guestQuantity
          ? _value.guestQuantity
          : guestQuantity // ignore: cast_nullable_to_non_nullable
              as int,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      eventDate: null == eventDate
          ? _value.eventDate
          : eventDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      organizerId: null == organizerId
          ? _value.organizerId
          : organizerId // ignore: cast_nullable_to_non_nullable
              as int,
      serviceItems: null == serviceItems
          ? _value._serviceItems
          : serviceItems // ignore: cast_nullable_to_non_nullable
              as List<ServiceItemForm>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      additionalDetails: null == additionalDetails
          ? _value.additionalDetails
          : additionalDetails // ignore: cast_nullable_to_non_nullable
              as String,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      createdQuote: freezed == createdQuote
          ? _value.createdQuote
          : createdQuote // ignore: cast_nullable_to_non_nullable
              as QuoteModel?,
    ));
  }
}

/// @nodoc

class _$QuoteFormStateImpl implements _QuoteFormState {
  const _$QuoteFormStateImpl(
      {required this.title,
      required this.eventType,
      required this.guestQuantity,
      required this.location,
      required this.eventDate,
      required this.organizerId,
      required final List<ServiceItemForm> serviceItems,
      required this.isLoading,
      this.additionalDetails = '',
      this.errorMessage,
      this.createdQuote})
      : _serviceItems = serviceItems;

  @override
  final String title;
  @override
  final String eventType;
  @override
  final int guestQuantity;
  @override
  final String location;
  @override
  final DateTime eventDate;
  @override
  final int organizerId;
  final List<ServiceItemForm> _serviceItems;
  @override
  List<ServiceItemForm> get serviceItems {
    if (_serviceItems is EqualUnmodifiableListView) return _serviceItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_serviceItems);
  }

  @override
  final bool isLoading;
  @override
  @JsonKey()
  final String additionalDetails;
  @override
  final String? errorMessage;
  @override
  final QuoteModel? createdQuote;

  @override
  String toString() {
    return 'QuoteFormState(title: $title, eventType: $eventType, guestQuantity: $guestQuantity, location: $location, eventDate: $eventDate, organizerId: $organizerId, serviceItems: $serviceItems, isLoading: $isLoading, additionalDetails: $additionalDetails, errorMessage: $errorMessage, createdQuote: $createdQuote)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuoteFormStateImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.eventType, eventType) ||
                other.eventType == eventType) &&
            (identical(other.guestQuantity, guestQuantity) ||
                other.guestQuantity == guestQuantity) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.eventDate, eventDate) ||
                other.eventDate == eventDate) &&
            (identical(other.organizerId, organizerId) ||
                other.organizerId == organizerId) &&
            const DeepCollectionEquality()
                .equals(other._serviceItems, _serviceItems) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.additionalDetails, additionalDetails) ||
                other.additionalDetails == additionalDetails) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.createdQuote, createdQuote) ||
                other.createdQuote == createdQuote));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      title,
      eventType,
      guestQuantity,
      location,
      eventDate,
      organizerId,
      const DeepCollectionEquality().hash(_serviceItems),
      isLoading,
      additionalDetails,
      errorMessage,
      createdQuote);

  /// Create a copy of QuoteFormState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuoteFormStateImplCopyWith<_$QuoteFormStateImpl> get copyWith =>
      __$$QuoteFormStateImplCopyWithImpl<_$QuoteFormStateImpl>(
          this, _$identity);
}

abstract class _QuoteFormState implements QuoteFormState {
  const factory _QuoteFormState(
      {required final String title,
      required final String eventType,
      required final int guestQuantity,
      required final String location,
      required final DateTime eventDate,
      required final int organizerId,
      required final List<ServiceItemForm> serviceItems,
      required final bool isLoading,
      final String additionalDetails,
      final String? errorMessage,
      final QuoteModel? createdQuote}) = _$QuoteFormStateImpl;

  @override
  String get title;
  @override
  String get eventType;
  @override
  int get guestQuantity;
  @override
  String get location;
  @override
  DateTime get eventDate;
  @override
  int get organizerId;
  @override
  List<ServiceItemForm> get serviceItems;
  @override
  bool get isLoading;
  @override
  String get additionalDetails;
  @override
  String? get errorMessage;
  @override
  QuoteModel? get createdQuote;

  /// Create a copy of QuoteFormState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuoteFormStateImplCopyWith<_$QuoteFormStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
