import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'profile_notifier.dart';
import 'profile_form_state.dart';
import '../../../data/datasources/remote/profile_service.dart';
import '../../../data/datasources/remote/api_client.dart';
import '../../../data/models/profile/profile_model.dart';

final profileServiceProvider = Provider<ProfileService>((ref) {
  final dio = ref.watch(dioProvider);
  return ProfileService(dio);
});

final currentProfileProvider = FutureProvider<ProfileModel?>((ref) async {
  const storage = FlutterSecureStorage();
  final userId = await storage.read(key: 'user_id');
  final profileIdStr = await storage.read(key: 'profile_id') ?? userId;
  if (profileIdStr == null) return null;

  final profileService = ref.watch(profileServiceProvider);
  try {
    return await profileService.getProfile(int.parse(profileIdStr));
  } catch (e) {
    return null;
  }
});

final profileFormProvider = 
  StateNotifierProvider<ProfileFormNotifier, ProfileFormState>((ref) {
  final profileService = ref.watch(profileServiceProvider);
  return ProfileFormNotifier(profileService);
});
