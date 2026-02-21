import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/assessment/presentation/screens/assessment_screen.dart';
import '../../features/profile_setup/presentation/screens/profile_setup_screen.dart';
import '../../features/profile_setup/presentation/screens/profile_setup_step2_screen.dart';
import '../../features/profile_setup/presentation/screens/profile_setup_step3_screen.dart';
import '../../features/profile_setup/presentation/screens/profile_setup_step4_screen.dart';
import '../../features/profile_setup/presentation/screens/profile_setup_step5_screen.dart';

part 'app_router.g.dart';

@riverpod
GoRouter appRouter(Ref ref) {
  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/assessment',
        name: 'assessment',
        builder: (context, state) => const AssessmentScreen(),
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
    ],
  );
}
