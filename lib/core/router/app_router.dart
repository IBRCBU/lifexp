import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:lifexp_app/features/achievements/presentation/screens/achievements_screen.dart';
import 'package:lifexp_app/features/auth/presentation/screens/login_screen.dart';
import 'package:lifexp_app/features/auth/presentation/screens/onboarding_screen.dart';
import 'package:lifexp_app/features/auth/presentation/screens/register_screen.dart';
import 'package:lifexp_app/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:lifexp_app/features/profile/presentation/screens/profile_screen.dart';
import 'package:lifexp_app/features/tasks/presentation/screens/tasks_screen.dart';
import 'package:lifexp_app/features/verification/presentation/screens/verification_screen.dart';
import 'package:lifexp_app/features/shared/app_shell.dart';

class AppRouter {
  AppRouter._();

  static GoRouter createRouter({
    required ValueListenable<bool> authenticationState,
  }) => GoRouter(
    initialLocation: authenticationState.value ? '/dashboard' : '/onboarding',
    refreshListenable: authenticationState,
    redirect: (context, state) {
      final isAuthRoute = switch (state.matchedLocation) {
        '/onboarding' || '/login' || '/register' => true,
        _ => false,
      };
      if (!authenticationState.value && !isAuthRoute) return '/onboarding';
      if (authenticationState.value && isAuthRoute) return '/dashboard';
      return null;
    },
    routes: [
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
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
          ),
          GoRoute(
            path: '/tasks',
            builder: (context, state) => const TasksScreen(),
          ),
          GoRoute(
            path: '/verify',
            builder: (context, state) => const VerificationScreen(),
          ),
          GoRoute(
            path: '/achievements',
            builder: (context, state) => const AchievementsScreen(),
          ),
          GoRoute(
            path: '/profile',
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),
    ],
  );
}
