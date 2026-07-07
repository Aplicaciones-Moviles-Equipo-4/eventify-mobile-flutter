import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'config/router/app_router.dart';

// Main entry point of the application.
// Riverpod's ProviderScope is initialized to manage state globally.
void main() {
  runApp(const ProviderScope(child: MyApp()));
}

// Main widget of the application that subscribes to Riverpod providers.
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Listens to the router provider to react to navigation/authentication changes.
    final router = ref.watch(goRouterProvider);

    return MaterialApp.router(
      title: 'Eventify Hosts',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routerConfig: router,
    );
  }
}
