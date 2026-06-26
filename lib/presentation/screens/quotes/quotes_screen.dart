import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/quotes/quotes_provider.dart';

class QuotesScreen extends ConsumerWidget {
  const QuotesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // For simplicity, showing how to list quotes. In a real app, we'd need a provider for all quotes of a host.
    // This is a placeholder since the backend allows fetching quotes by organizer or specific ID.
    return Scaffold(
      appBar: AppBar(title: const Text('Mis Cotizaciones')),
      body: const Center(
        child: Text('Lista de cotizaciones (Pendiente implementar filtro por Host en Backend o Provider)'),
      ),
    );
  }
}
