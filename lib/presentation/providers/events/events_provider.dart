import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/datasources/remote/event_service.dart';
import '../../../data/datasources/remote/api_client.dart';
import '../../../data/models/event/social_event_model.dart';
import '../profile/profile_provider.dart';

final eventServiceProvider = Provider<EventService>((ref) {
  final dio = ref.watch(dioProvider);
  return EventService(dio);
});

final myEventsProvider = FutureProvider<List<SocialEventModel>>((ref) async {
  final eventService = ref.watch(eventServiceProvider);
  final profile = await ref.watch(currentProfileProvider.future);
  
  if (profile != null) {
    return eventService.getEventsByCustomer(profile.fullName);
  }
  return [];
});
