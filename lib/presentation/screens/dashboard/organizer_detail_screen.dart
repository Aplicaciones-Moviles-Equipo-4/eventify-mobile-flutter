import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/organizers/organizers_provider.dart';
class OrganizerDetailScreen extends ConsumerWidget {
  final int organizerId;

  const OrganizerDetailScreen({Key? key, required this.organizerId}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final organizerAsync = ref.watch(organizerDetailProvider(organizerId));
    final reviewsAsync = ref.watch(organizerReviewsProvider(organizerId));

    return Scaffold(
      appBar: AppBar(title: const Text('Detalle del Organizador')),
      body: organizerAsync.when(
        data: (organizer) => SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(organizer.fullName, style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 8),
              Text(organizer.email),
              Text(organizer.fullAddress),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => context.go('/dashboard/organizer/\$organizerId/quote'),
                child: const Text('Solicitar Cotización'),
              ),
              const SizedBox(height: 24),
              const Text('Reseñas', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              reviewsAsync.when(
                data: (reviews) => reviews.isEmpty 
                  ? const Text('No hay reseñas aún')
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: reviews.length,
                      itemBuilder: (context, index) {
                        final review = reviews[index];
                        return ListTile(
                          title: Text('\${review.fullName} — Rating: \${review.rating}/5'),
                          subtitle: Text(review.content),
                        );
                      },
                    ),
                loading: () => const CircularProgressIndicator(),
                error: (err, stack) => Text('Error al cargar reseñas: \$err'),
              ),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: \$err')),
      ),
    );
  }
}
