import '../profile/profile_model.dart';

class OrganizerModel {
  final ProfileModel profile;
  final List<String> services;
  final List<String> photoUrls;
  final String? phone;
  final double rating;

  OrganizerModel({
    required this.profile,
    required this.services,
    required this.photoUrls,
    this.phone,
    required this.rating,
  });

  // Mock factory to enhance ProfileModel since the backend doesn't provide these yet
  factory OrganizerModel.fromProfile(ProfileModel profile, {double rating = 4.5}) {
    return OrganizerModel(
      profile: profile,
      services: [
        'Organización completa',
        'Catering',
        'Decoración temática',
        'Música y DJ',
        'Fotografía profesional'
      ], // TODO: Conectar con endpoint real de servicios del organizador
      photoUrls: [
        'https://images.unsplash.com/photo-1511795409834-ef04bbd61622?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
        'https://images.unsplash.com/photo-1464366400600-7168b8af9bc3?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
        'https://images.unsplash.com/photo-1519167758481-83f550bb49b3?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
        'https://images.unsplash.com/photo-1465495976277-4387d4b0b4c6?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
      ], // TODO: Conectar con endpoint real de galería
      phone: '+1 234 567 8900', // TODO: Conectar con endpoint real de teléfono
      rating: rating,
    );
  }
}
