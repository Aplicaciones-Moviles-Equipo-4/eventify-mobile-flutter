import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../auth/auth_provider.dart';
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
  // Observamos el estado de auth. Si el usuario cambia o sale, este provider se reinicia.
  final authState = ref.watch(authProvider);
  
  return authState.maybeWhen(
    authenticated: (user) async {
      const storage = FlutterSecureStorage();
      final profileService = ref.watch(profileServiceProvider);
      
      // 1. Intentamos leer de almacenamiento local
      String? profileIdStr = await storage.read(key: 'profile_id_${user.id}');
      
      if (profileIdStr != null) {
        try {
          return await profileService.getProfile(int.parse(profileIdStr));
        } catch (e) {
          // Si el ID guardado ya no es válido, seguimos al siguiente paso
          await storage.delete(key: 'profile_id_${user.id}');
        }
      }

      // 2. Si no hay ID local, intentamos buscar por nombre de usuario (que es el email en este backend)
      try {
        final profile = await profileService.getProfileByEmail(user.username);
        // Guardamos el ID encontrado para futuras consultas
        await storage.write(key: 'profile_id_${user.id}', value: profile.id.toString());
        return profile;
      } catch (e) {
        return null;
      }
    },
    orElse: () => null,
  );
});

final profileFormProvider = 
  StateNotifierProvider<ProfileFormNotifier, ProfileFormState>((ref) {
  final profileService = ref.watch(profileServiceProvider);
  return ProfileFormNotifier(profileService);
});
