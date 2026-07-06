import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/events/events_provider.dart';

class EventsScreen extends ConsumerWidget {
  const EventsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventsAsync = ref.watch(myEventsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Mis Eventos')),
      body: eventsAsync.when(
        data: (events) => events.isEmpty
          ? const Center(child: Text('No tienes eventos activos'))
          : ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(event.title),
                    subtitle: Text('${event.eventDate.toLocal()} - ${event.location}'),
                    trailing: Chip(label: Text(event.status)),
                  ),
                );
              },
            ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
