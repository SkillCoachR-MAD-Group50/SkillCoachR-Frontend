import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/routing/app_router.dart';
import 'core/theme/app_theme.dart';

import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart'; // Uncomment after running 'flutterfire configure'

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase (will use google-services.json/GoogleService-Info.plist)
  await Firebase.initializeApp(
    // options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const ProviderScope(
      child: SkillCoachRApp(),
    ),
  );
}

class SkillCoachRApp extends ConsumerWidget {
  const SkillCoachRApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'SkillCoachR',
      theme: AppTheme.lightTheme,
      routerConfig: goRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
