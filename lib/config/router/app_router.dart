import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/screens/auth/login_screen.dart';
import '../../presentation/screens/auth/register_screen.dart';
import '../../presentation/screens/splash/splash_screen.dart';
import '../../presentation/screens/dashboard/dashboard_screen.dart';
import '../../presentation/screens/dashboard/organizer_detail_screen.dart';
import '../../presentation/screens/profile/profile_screen.dart';
import '../../presentation/screens/profile/profile_setup_screen.dart';
import '../../presentation/screens/quotes/quotes_screen.dart';
import '../../presentation/screens/quotes/quote_form_screen.dart';
import '../../presentation/screens/events/events_screen.dart';
import '../../presentation/screens/app_shell.dart';
import '../../presentation/providers/auth/auth_provider.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) => AppShell(child: child),
        routes: [
          GoRoute(
            path: '/dashboard',
            builder: (context, state) => const DashboardScreen(),
            routes: [
              GoRoute(
                path: 'organizer/:id',
                builder: (context, state) {
                  final id = int.parse(state.pathParameters['id']!);
                  return OrganizerDetailScreen(organizerId: id);
                },
                routes: [
                  GoRoute(
                    path: 'quote',
                    builder: (context, state) {
                      final id = int.parse(state.pathParameters['id']!);
                      return QuoteFormScreen(organizerId: id);
                    },
                  ),
                ],
              ),
            ],
          ),
          GoRoute(
            path: '/quotes',
            builder: (context, state) => const QuotesScreen(),
          ),
          GoRoute(
            path: '/events',
            builder: (context, state) => const EventsScreen(),
          ),
          GoRoute(
            path: '/profile',
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),
      GoRoute(
        path: '/profile-setup',
        builder: (context, state) => const ProfileSetupScreen(),
      ),
    ],
    redirect: (context, state) {
      final isAuthenticated = ref.read(isAuthenticatedProvider);
      final isLoggingIn = state.uri.toString() == '/login' || state.uri.toString() == '/register' || state.uri.toString() == '/splash';

      if (!isAuthenticated && !isLoggingIn) return '/login';
      if (isAuthenticated && isLoggingIn) return '/dashboard';

      return null;
    },
  );
});
