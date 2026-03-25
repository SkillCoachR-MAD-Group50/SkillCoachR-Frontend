import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/assessment/presentation/screens/assessment_screen.dart';
import '../../features/assessment/presentation/screens/gap_analysis_screen.dart';
import '../../features/profile_setup/presentation/screens/profile_setup_screen.dart';
import '../../features/profile_setup/presentation/screens/profile_setup_step2_screen.dart';
import '../../features/profile_setup/presentation/screens/profile_setup_step3_screen.dart';
import '../../features/profile_setup/presentation/screens/profile_setup_step4_screen.dart';
import '../../features/profile_setup/presentation/screens/profile_setup_step5_screen.dart';
import '../../features/roadmap/presentation/screens/roadmap_screen.dart';
import '../models/milestone.dart';


import '../../features/auth/presentation/screens/login_screen.dart';
import '../services/auth_service.dart';

part 'app_router.g.dart';

@riverpod
GoRouter appRouter(AppRouterRef ref) {
  final authState = ref.watch(authServiceProvider);

  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final user = authState.valueOrNull;
      final isLoggingIn = state.matchedLocation == '/login';

      if (user == null) {
        // Protected routes that require login
        final protectedRoutes = [
          '/assessment',
          '/gap-analysis',
          '/profile-setup',
          '/dashboard',
        ];

        if (protectedRoutes.any((route) => state.matchedLocation.startsWith(route))) {
          return '/login';
        }
      } else {
        // If logged in, redirect away from login screen
        if (isLoggingIn) {
          return '/';
        }
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/assessment',
        name: 'assessment',
        builder: (context, state) => const AssessmentScreen(),
      ),
      GoRoute(
        path: '/gap-analysis',
        name: 'gap_analysis',
        builder: (context, state) => const GapAnalysisScreen(),
      ),
      GoRoute(
        path: '/profile-setup',
        name: 'profile_setup',
        builder: (context, state) => const ProfileSetupScreen(),
      ),
      GoRoute(
        path: '/profile-setup-step2',
        name: 'profile_setup_step2',
        builder: (context, state) => const ProfileSetupStep2Screen(),
      ),
      GoRoute(
        path: '/profile-setup-step3',
        name: 'profile_setup_step3',
        builder: (context, state) => const ProfileSetupStep3Screen(),
      ),
      GoRoute(
        path: '/profile-setup-step4',
        name: 'profile_setup_step4',
        builder: (context, state) => const ProfileSetupStep4Screen(),
      ),
      GoRoute(
        path: '/profile-setup-step5',
        name: 'profile_setup_step5',
        builder: (context, state) => const ProfileSetupStep5Screen(),
      ),
      GoRoute(
        path: '/dashboard',
        name: 'dashboard',
        builder: (context, state) {
          final extras = state.extra as Map<String, dynamic>?;
          return RoadmapScreen(
            goal: extras?['goal'] ?? '',
            skill: extras?['skill'] ?? '',
            milestones: (extras?['milestones'] as List?)?.cast<Milestone>() ?? [],
          );
        },
      ),
    ],
  );
}

