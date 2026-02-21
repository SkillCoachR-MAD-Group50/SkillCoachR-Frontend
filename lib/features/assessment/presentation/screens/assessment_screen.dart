import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:go_router/go_router.dart';

import '../providers/assessment_provider.dart';
import '../widgets/rating_slider.dart';

class AssessmentScreen extends ConsumerWidget {
  const AssessmentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get the current ratings state
    final ratings = ref.watch(assessmentProvider);

    // List of skills to assess
    final List<Map<String, dynamic>> categories = [
      {
        'category': 'Backend Development',
        'icon': PhosphorIcons.database(),
        'color': Colors.blue,
        'skills': ['Java / Spring Boot', 'Node.js', 'SQL / Relational DBs', 'System Design'],
      },
      {
        'category': 'Frontend Frameworks',
        'icon': PhosphorIcons.browser(),
        'color': Colors.orange,
        'skills': ['React or Vue', 'Flutter / Dart', 'CSS / Tailwind CSS'],
      },
      {
        'category': 'Cloud & DevOps',
        'icon': PhosphorIcons.cloud(),
        'color': Colors.teal,
        'skills': ['Docker / Containers', 'CI/CD Pipelines', 'AWS / Google Cloud'],
      }
    ];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(PhosphorIcons.arrowLeft(), color: Colors.black87),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Skill Assessment',
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          // Top Progress bar representing they are doing the assessment
          child: LinearProgressIndicator(
            value: 0.3, // Example fixed value for visual flair
            backgroundColor: Colors.grey.shade200,
            color: const Color(0xFF0052D4),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(24.0),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                final skillsList = category['skills'] as List<String>;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category Header
                    Row(
                      children: [
                        Icon(category['icon'], color: category['color'], size: 24),
                        const SizedBox(width: 12),
                        Text(
                          category['category'],
                          style: GoogleFonts.outfit(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // List of skills in this category
                    ...skillsList.map((skillName) {
                      final currentRating = ratings[skillName] ?? 1.0;
                      return RatingSlider(
                        skillName: skillName,
                        rating: currentRating,
                        onChanged: (newValue) {
                          ref
                              .read(assessmentProvider.notifier)
                              .updateSkillRating(skillName, newValue);
                        },
                      );
                    }),
                    const SizedBox(height: 16),
                    // Divider between categories (except the last one)
                    if (index < categories.length - 1) ...[
                      const Divider(height: 32),
                    ]
                  ],
                );
              },
            ),
          ),
          
          // Submit Button Area
          Container(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(13),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  // In a real app, we would calculate gap analysis here
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'AI is analyzing your skills...',
                        style: GoogleFonts.inter(),
                      ),
                      backgroundColor: const Color(0xFF0052D4),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0052D4),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(PhosphorIcons.brain()),
                    const SizedBox(width: 8),
                    Text(
                      'Analyze My Skills',
                      style: GoogleFonts.outfit(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
