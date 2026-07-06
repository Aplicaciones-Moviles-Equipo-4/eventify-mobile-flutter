import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/organizers/organizers_provider.dart';
import '../../../data/models/organizer/organizer_model.dart';
import '../../widgets/common/photo_gallery_strip.dart';
import '../../widgets/common/service_chip.dart';

class OrganizerDetailScreen extends ConsumerWidget {
  final int organizerId;

  const OrganizerDetailScreen({Key? key, required this.organizerId}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final organizerAsync = ref.watch(organizerDetailProvider(organizerId));
    final reviewsAsync = ref.watch(organizerReviewsProvider(organizerId));

    return Scaffold(
      body: organizerAsync.when(
        data: (profile) {
          // Wrap profile in OrganizerModel to add mock data
          final organizer = OrganizerModel.fromProfile(profile);

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 250,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(organizer.profile.fullName),
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.secondary],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            organizer.profile.fullName.isNotEmpty ? organizer.profile.fullName[0].toUpperCase() : '?',
                            style: const TextStyle(fontSize: 80, color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      // Semi-transparent overlay to make text readable
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Contact Info
                      Row(
                        children: [
                          Icon(Icons.email, color: Colors.grey[600]),
                          const SizedBox(width: 8),
                          Text(organizer.profile.email),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.phone, color: Colors.grey[600]),
                          const SizedBox(width: 8),
                          Text(organizer.phone ?? 'No disponible'),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.location_on, color: Colors.grey[600]),
                          const SizedBox(width: 8),
                          Expanded(child: Text(organizer.profile.fullAddress)),
                        ],
                      ),
                      const SizedBox(height: 24),
                      
                      // Services
                      const Text('Servicios ofrecidos', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: organizer.services.map((s) => ServiceChip(label: s)).toList(),
                      ),
                      const SizedBox(height: 24),

                      // Photo Gallery
                      const Text('Galería', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 12),
                      PhotoGalleryStrip(photoUrls: organizer.photoUrls),
                      const SizedBox(height: 24),

                      // Reviews
                      Row(
                        children: [
                          const Text('Reseñas', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          const Spacer(),
                          Row(
                            children: [
                              const Icon(Icons.star, color: Colors.amber, size: 20),
                              const SizedBox(width: 4),
                              Text('${organizer.rating.toStringAsFixed(1)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      reviewsAsync.when(
                        data: (reviews) => reviews.isEmpty 
                          ? const Text('No hay reseñas aún', style: TextStyle(color: Colors.grey))
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.zero,
                              itemCount: reviews.length,
                              itemBuilder: (context, index) {
                                final review = reviews[index];
                                return Card(
                                  margin: const EdgeInsets.only(bottom: 8),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(review.fullName, style: const TextStyle(fontWeight: FontWeight.bold)),
                                            Row(
                                              children: List.generate(
                                                5,
                                                (i) => Icon(
                                                  i < review.rating ? Icons.star : Icons.star_border,
                                                  color: Colors.amber,
                                                  size: 16,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        Text(review.content),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                        loading: () => const Center(child: CircularProgressIndicator()),
                        error: (err, stack) => Text('Error al cargar reseñas: $err'),
                      ),
                      const SizedBox(height: 100), // Spacing for bottom button
                    ],
                  ),
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
              textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () => context.go('/dashboard/organizer/$organizerId/quote'),
            child: const Text('Cotizar 🎉'),
          ),
        ),
      ),
    );
  }
}
