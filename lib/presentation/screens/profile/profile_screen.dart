import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/auth/auth_provider.dart';
import '../../providers/profile/profile_provider.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(currentProfileProvider);
    final user = ref.watch(currentUserProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Perfil'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => ref.read(authProvider.notifier).logout(),
          ),
        ],
      ),
      body: profileAsync.when(
        data: (profile) => profile == null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('No has configurado tu perfil'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.push('/profile-setup');
                    },
                    child: const Text('Configurar Perfil'),
                  ),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: CircleAvatar(radius: 50, child: Icon(Icons.person, size: 50)),
                  ),
                  const SizedBox(height: 24),
                  _InfoTile(label: 'Nombre Completo', value: profile.fullName),
                  _InfoTile(label: 'Email', value: profile.email),
                  _InfoTile(label: 'Dirección', value: profile.fullAddress),
                  _InfoTile(label: 'Ciudad', value: profile.city),
                  _InfoTile(label: 'País', value: profile.country),
                  const SizedBox(height: 24),
                  _InfoTile(label: 'Usuario (Auth)', value: user?.username ?? ''),
                ],
              ),
            ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final String label;
  final String value;

  const _InfoTile({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
          Text(value, style: const TextStyle(fontSize: 16)),
          const Divider(),
        ],
      ),
    );
  }
}
