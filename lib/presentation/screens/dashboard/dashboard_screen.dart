import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/organizers/organizers_provider.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final organizersAsync = ref.watch(organizersListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Organizadores'),
      ),
      body: organizersAsync.when(
        data: (organizers) => ListView.builder(
          itemCount: organizers.length,
          itemBuilder: (context, index) {
            final organizer = organizers[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListTile(
                title: Text(organizer.fullName),
                subtitle: Text('\${organizer.city}, \${organizer.country}'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.go('/dashboard/organizer/\${organizer.id}'),
              ),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: \$err')),
      ),
    );
  }
}
