import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'profile_form_state.dart';
import '../../../data/datasources/remote/profile_service.dart';

class ProfileFormNotifier extends StateNotifier<ProfileFormState> {
  final ProfileService profileService;

  ProfileFormNotifier(this.profileService) 
    : super(const ProfileFormState.initial());

  Future<void> createProfile({
    required String firstName,
    required String lastName,
    required String email,
    required String street,
    required String number,
    required String city,
    required String postalCode,
    required String country,
  }) async {
    state = const ProfileFormState.loading();
    try {
      final profile = await profileService.createProfile(
        firstName: firstName,
        lastName: lastName,
        email: email,
        street: street,
        number: number,
        city: city,
        postalCode: postalCode,
        country: country,
      );
      state = ProfileFormState.success(profile);
    } catch (e) {
      state = ProfileFormState.error(e.toString());
    }
  }
}
