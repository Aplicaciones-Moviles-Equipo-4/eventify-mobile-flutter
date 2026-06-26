import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../data/models/profile/profile_model.dart';

part 'profile_form_state.freezed.dart';

@freezed
class ProfileFormState with _$ProfileFormState {
  const factory ProfileFormState.initial() = _Initial;
  const factory ProfileFormState.loading() = _Loading;
  const factory ProfileFormState.success(ProfileModel profile) = _Success;
  const factory ProfileFormState.error(String message) = _Error;
}
