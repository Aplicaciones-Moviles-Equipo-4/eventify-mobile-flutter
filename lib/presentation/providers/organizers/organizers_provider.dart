import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/datasources/remote/organizer_service.dart';
import '../../../data/datasources/remote/profile_service.dart';
import '../../../data/datasources/remote/review_service.dart';
import '../../../data/datasources/remote/api_client.dart';
import '../../../data/models/profile/profile_model.dart';
import '../../../data/models/review/review_model.dart';
import '../profile/profile_provider.dart';

final organizerServiceProvider = Provider<OrganizerService>((ref) {
  final dio = ref.watch(dioProvider);
  return OrganizerService(dio);
});

final reviewServiceProvider = Provider<ReviewService>((ref) {
  final dio = ref.watch(dioProvider);
  return ReviewService(dio);
});

final organizersListProvider = FutureProvider<List<ProfileModel>>((ref) async {
  final organizerService = ref.watch(organizerServiceProvider);
  return organizerService.getOrganizers();
});

final organizerDetailProvider = 
  FutureProvider.family<ProfileModel, int>((ref, organizerId) async {
  final profileService = ref.watch(profileServiceProvider);
  return profileService.getProfile(organizerId);
});

final organizerReviewsProvider = 
  FutureProvider.family<List<ReviewModel>, int>((ref, organizerId) async {
  final reviewService = ref.watch(reviewServiceProvider);
  return reviewService.getReviewsByProfile(organizerId);
});

final organizerAverageRatingProvider = 
  FutureProvider.family<double, int>((ref, organizerId) async {
  final reviews = await ref.watch(organizerReviewsProvider(organizerId).future);
  final reviewService = ref.watch(reviewServiceProvider);
  return reviewService.calculateAverageRating(reviews);
});
