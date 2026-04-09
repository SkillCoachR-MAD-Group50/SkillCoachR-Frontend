import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/services/auth_service.dart';
import '../../../../core/services/app_prefs.dart';
import '../../../../core/models/milestone.dart';
import '../../../profile/presentation/screens/profile_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppTheme.bgGradient),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Top Bar
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.red.withOpacity(0.5),
                              ),
                            ),
                            child: IconButton(
                              icon: Icon(
                                PhosphorIcons.signOut(),
                                color: Colors.redAccent.shade100,
                              ),
                              tooltip: 'Sign Out',
                              onPressed: () async {
                                final authService = ref.read(
                                  authServiceProvider,
                                );
                                await authService.logout();
                                if (context.mounted) {
                                  context.go('/login');
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Logo and Title
                    const _HeaderSection(),
                    const SizedBox(height: 30),

                    // AI Coach Banner
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.0),
                      child: _AICoachBanner(),
                    ),
                    const SizedBox(height: 30),

                    // Navigation Grid
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: 1.5,
                        children: [
                          _NavCard(
                            title: 'Smart Analysis',
                            subtitle: 'AI assessment',
                            icon: PhosphorIcons.brain(),
                            color: Colors.blue,
                            onTap: () => context.push('/profile-setup'),
                          ),
                          _NavCard(
                            title: 'Custom Paths',
                            subtitle: 'Tailored roadmaps',
                            icon: PhosphorIcons.target(),
                            color: Colors.teal,
                            onTap: () async {
                              final prefsData = await AppPrefs.load();
                              if (prefsData != null && context.mounted) {
                                final milestonesJson =
                                    prefsData['milestones'] as List<dynamic>? ??
                                    [];
                                if (milestonesJson.isNotEmpty) {
                                  final goal = prefsData['goal'] ?? '';
                                  final skill = prefsData['skill'] ?? '';
                                  final milestones = milestonesJson
                                      .map(
                                        (m) => Milestone.fromSaved(
                                          (m as Map).cast<String, dynamic>(),
                                        ),
                                      )
                                      .toList();
                                  context.push(
                                    '/dashboard',
                                    extra: {
                                      'goal': goal,
                                      'skill': skill,
                                      'milestones': milestones,
                                    },
                                  );
                                  return;
                                }
                              }
                              if (context.mounted)
                                context.push('/profile-setup');
                            },
                          ),
                          _NavCard(
                            title: 'Track Progress',
                            subtitle: 'Real-time analytics',
                            icon: PhosphorIcons.chartLineUp(),
                            color: Colors.orange,
                            onTap: () async {
                              final prefsData = await AppPrefs.load();
                              if (prefsData != null && context.mounted) {
                                final goal = prefsData['goal'] ?? '';
                                final skill = prefsData['skill'] ?? '';
                                final milestonesJson =
                                    prefsData['milestones'] as List<dynamic>? ??
                                    [];
                                final milestones = milestonesJson
                                    .map(
                                      (m) => Milestone.fromSaved(
                                        (m as Map).cast<String, dynamic>(),
                                      ),
                                    )
                                    .toList();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => ProfileScreen(
                                      goal: goal,
                                      skill: skill,
                                      milestones: milestones,
                                      streak: prefsData['streak'] as int? ?? 1,
                                    ),
                                  ),
                                );
                              } else if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Take the assessment to track your progress!',
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                          _NavCard(
                            title: 'AI Guidance',
                            subtitle: 'Smart tips',
                            icon: PhosphorIcons.sparkle(),
                            color: Colors.cyan,
                            onTap: () async {
                              final prefsData = await AppPrefs.load();
                              if (prefsData != null && context.mounted) {
                                final goal = prefsData['goal'] ?? '';
                                final skill = prefsData['skill'] ?? '';
                                final milestonesJson =
                                    prefsData['milestones'] as List<dynamic>? ??
                                    [];
                                final milestones = milestonesJson
                                    .map(
                                      (m) => Milestone.fromSaved(
                                        (m as Map).cast<String, dynamic>(),
                                      ),
                                    )
                                    .toList();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => ProfileScreen(
                                      goal: goal,
                                      skill: skill,
                                      milestones: milestones,
                                      streak: prefsData['streak'] as int? ?? 1,
                                    ),
                                  ),
                                );
                              } else if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Take an assessment for AI recommendations!',
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),

              const SliverFillRemaining(
                hasScrollBody: false,
                fillOverscroll: true,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Bottom Footer
                    _BottomFooter(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeaderSection extends StatelessWidget {
  const _HeaderSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset('assets/images/logo.png', width: 280, fit: BoxFit.contain),
        const SizedBox(height: 20),
        Text(
          'Your AI Learning Partner',
          style: GoogleFonts.outfit(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Transform your career with AI-powered skill development',
          style: GoogleFonts.inter(fontSize: 12, color: Colors.white70),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _AICoachBanner extends StatelessWidget {
  const _AICoachBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF6FB1FC), Color(0xFF4364F7)],
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Icon(Icons.face, color: Colors.white, size: 30),
          ),
          const SizedBox(width: 16),
          // Text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'AI Coach',
                      style: GoogleFonts.outfit(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.accentLight,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.more_horiz,
                      color: Colors.white54,
                      size: 16,
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  "Hi! I'm your AI coach. Let's reach your goals!",
                  style: GoogleFonts.inter(color: Colors.white, fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NavCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _NavCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.03),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.08)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                shape: BoxShape.circle,
                border: Border.all(color: color.withOpacity(0.3)),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const Spacer(),
            Text(
              title,
              style: GoogleFonts.outfit(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: GoogleFonts.inter(
                fontSize: 10,
                color: AppTheme.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomFooter extends StatelessWidget {
  const _BottomFooter();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 30),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.02),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        border: Border(top: BorderSide(color: Colors.white.withOpacity(0.05))),
      ),
      child: Column(
        children: [
          // Get Started Button
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () async {
                // Try to load existing roadmap
                final prefsData = await AppPrefs.load();
                if (prefsData != null && context.mounted) {
                  final goal = prefsData['goal'] ?? '';
                  final skill = prefsData['skill'] ?? '';
                  final milestonesJson =
                      prefsData['milestones'] as List<dynamic>? ?? [];

                  if (milestonesJson.isNotEmpty) {
                    final milestones = milestonesJson
                        .map(
                          (m) => Milestone.fromSaved(
                            (m as Map).cast<String, dynamic>(),
                          ),
                        )
                        .toList();
                    context.push(
                      '/dashboard',
                      extra: {
                        'goal': goal,
                        'skill': skill,
                        'milestones': milestones,
                      },
                    );
                    return;
                  }
                }

                if (context.mounted) {
                  context.push('/profile-setup');
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.accent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                elevation: 4,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Get Started',
                    style: GoogleFonts.outfit(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(PhosphorIcons.arrowRight()),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Join thousands achieving their goals',
            style: GoogleFonts.inter(
              color: Colors.white54,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
