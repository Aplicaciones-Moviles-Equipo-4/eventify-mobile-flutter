import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/organizers/organizers_provider.dart';
import '../../providers/auth/auth_provider.dart';
import '../../widgets/common/organizer_card.dart';
import '../../../data/models/organizer/organizer_model.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final organizersAsync = ref.watch(organizersListProvider);
    final user = ref.watch(currentUserProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Hola, ${user?.username ?? "Anfitrión"} 👋'),
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Encuentra al organizador perfecto para tu evento',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: organizersAsync.when(
              data: (profiles) {
                if (profiles.isEmpty) {
                  return const Center(child: Text('No hay organizadores disponibles en este momento.'));
                }
                
                // Convert ProfileModel to OrganizerModel
                final organizers = profiles.map((p) => OrganizerModel.fromProfile(p)).toList();

                return GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: organizers.length,
                  itemBuilder: (context, index) {
                    final organizer = organizers[index];
                    return OrganizerCard(
                      organizer: organizer,
                      onTap: () => context.go('/dashboard/organizer/${organizer.profile.id}'),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err')),
            ),
          ),
        ],
      ),
    );
  }
}
