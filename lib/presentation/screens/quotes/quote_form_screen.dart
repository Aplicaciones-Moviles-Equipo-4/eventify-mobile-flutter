import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/quotes/quotes_provider.dart';
import '../../providers/quotes/quote_form_state.dart';
import '../../providers/auth/auth_provider.dart';

class QuoteFormScreen extends ConsumerWidget {
  final int organizerId;

  const QuoteFormScreen({Key? key, required this.organizerId}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(quoteFormProvider(organizerId));
    final formNotifier = ref.read(quoteFormProvider(organizerId).notifier);
    final user = ref.watch(currentUserProvider);

    ref.listen(quoteFormProvider(organizerId), (previous, next) {
      if (next.createdQuote != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Cotización enviada con éxito')),
        );
        context.go('/quotes');
      }
      if (next.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.errorMessage!)),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Solicitar Cotización')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Título'),
              onChanged: formNotifier.updateTitle,
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(labelText: 'Tipo de Evento'),
              onChanged: formNotifier.updateEventType,
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(labelText: 'Ubicación'),
              onChanged: formNotifier.updateLocation,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Text('Invitados: \${formState.guestQuantity}'),
                ),
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () => formNotifier.updateGuestQuantity(formState.guestQuantity - 1),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => formNotifier.updateGuestQuantity(formState.guestQuantity + 1),
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Servicios', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                IconButton(icon: const Icon(Icons.add), onPressed: formNotifier.addServiceItem),
              ],
            ),
            ...formState.serviceItems.asMap().entries.map((entry) {
              int idx = entry.key;
              ServiceItemForm item = entry.value;
              return Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: const InputDecoration(labelText: 'Descripción'),
                          onChanged: (val) => formNotifier.updateServiceItem(idx, item.copyWith(description: val)),
                        ),
                      ),
                      const SizedBox(width: 8),
                      SizedBox(
                        width: 60,
                        child: TextField(
                          decoration: const InputDecoration(labelText: 'Cant.'),
                          keyboardType: TextInputType.number,
                          onChanged: (val) => formNotifier.updateServiceItem(idx, item.copyWith(quantity: int.tryParse(val) ?? 1)),
                        ),
                      ),
                      const SizedBox(width: 8),
                      SizedBox(
                        width: 80,
                        child: TextField(
                          decoration: const InputDecoration(labelText: 'Precio'),
                          keyboardType: TextInputType.number,
                          onChanged: (val) => formNotifier.updateServiceItem(idx, item.copyWith(unitPrice: double.tryParse(val) ?? 0)),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => formNotifier.removeServiceItem(idx),
                      ),
                    ],
                  ),
                ],
              );
            }).toList(),
            const SizedBox(height: 24),
            Text('Presupuesto Total: \${formState.totalBudget}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: formState.isLoading ? null : () {
                  if (user != null) {
                    formNotifier.submitQuote(hostId: user.id);
                  }
                },
                child: formState.isLoading 
                  ? const CircularProgressIndicator()
                  : const Text('Enviar Cotización'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
