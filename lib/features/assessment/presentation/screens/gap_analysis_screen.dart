import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../../core/theme/app_theme.dart';

class GapAnalysisScreen extends StatelessWidget {
  const GapAnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(PhosphorIcons.caretLeft(), color: Colors.black87),
                      onPressed: () => context.pop(),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Skill Gap Analysis',
                          style: GoogleFonts.outfit(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF1E293B),
                          ),
                        ),
                        Text(
                          'See how you compare',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: Colors.blueGrey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Color(0xFFE0F2FE),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    PhosphorIcons.target(),
                    color: const Color(0xFF3B82F6),
                    size: 24,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // AI Coach Banner
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF6FF), // Light blue background
                border: Border.all(color: const Color(0xFFD6E4F8)),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF6FB1FC), Color(0xFF1C5CE5)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(PhosphorIcons.robot(PhosphorIconsStyle.fill), color: Colors.white, size: 24),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'AI Coach',
                              style: GoogleFonts.outfit(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                            const SizedBox(width: 4),
                            Icon(PhosphorIcons.dotsThree(), color: const Color(0xFF00C7D4), size: 16),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "I've analyzed your skills against industry benchmarks. Here's what I found...",
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            color: const Color(0xFF334155),
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Radar Chart Section
            SizedBox(
              height: 300,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Optional: decorative background circle
                  Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFF8FAFC),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                  ),
                  RadarChart(
                    RadarChartData(
                      dataSets: [
                        // Industry Benchmark (Target)
                        RadarDataSet(
                          fillColor: const Color(0xFF94A3B8).withValues(alpha: 0.2), // Light gray fill
                          borderColor: const Color(0xFF94A3B8), // Gray line
                          entryRadius: 0,
                          dataEntries: [
                            const RadarEntry(value: 5),
                            const RadarEntry(value: 4.5),
                            const RadarEntry(value: 5),
                            const RadarEntry(value: 4),
                            const RadarEntry(value: 4.5),
                            const RadarEntry(value: 4),
                          ],
                          borderWidth: 2,
                        ),
                        // User Current Skills
                        RadarDataSet(
                          fillColor: const Color(0xFF3B82F6).withValues(alpha: 0.4), // Blue fill
                          borderColor: const Color(0xFF3B82F6), // Blue line
                          entryRadius: 3,
                          dataEntries: [
                            const RadarEntry(value: 2), // e.g., Backend
                            const RadarEntry(value: 3), // e.g., Databases
                            const RadarEntry(value: 1), // e.g., APIs
                            const RadarEntry(value: 4), // e.g., Frontend
                            const RadarEntry(value: 2), // e.g., Cloud
                            const RadarEntry(value: 3), // e.g., Testing
                          ],
                          borderWidth: 2,
                        ),
                      ],
                      radarBackgroundColor: Colors.transparent,
                      borderData: FlBorderData(show: false),
                      radarBorderData: const BorderSide(color: Color(0xFFE2E8F0), width: 1),
                      tickCount: 5,
                      ticksTextStyle: const TextStyle(color: Colors.transparent, fontSize: 10),
                      tickBorderData: const BorderSide(color: Color(0xFFF1F5F9)),
                      gridBorderData: const BorderSide(color: Color(0xFFE2E8F0), width: 1.5),
                      getTitle: (index, angle) {
                        final titles = ['Backend', 'Databases', 'APIs', 'Frontend', 'Cloud', 'Testing'];
                        return RadarChartTitle(
                          text: titles[index],
                          angle: 0,
                          positionPercentageOffset: 0.1,
                        );
                      },
                      titleTextStyle: GoogleFonts.inter(
                        color: const Color(0xFF475569),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    swapAnimationDuration: const Duration(milliseconds: 800),
                  ),
                ],
              ),
            ),
            
            // Legend
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(width: 12, height: 12, color: const Color(0xFF3B82F6).withValues(alpha: 0.5)),
                    const SizedBox(width: 6),
                    Text('You', style: GoogleFonts.inter(fontSize: 12, color: const Color(0xFF64748B))),
                  ],
                ),
                const SizedBox(width: 24),
                Row(
                  children: [
                    Container(width: 12, height: 12, color: const Color(0xFF94A3B8).withValues(alpha: 0.3)),
                    const SizedBox(width: 6),
                    Text('Benchmark', style: GoogleFonts.inter(fontSize: 12, color: const Color(0xFF64748B))),
                  ],
                ),
              ],
            ),
            
            const SizedBox(height: 32),
            
            // Insights Cards
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEF2F2), // Soft Red
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFFECACA)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(PhosphorIcons.warningCircle(PhosphorIconsStyle.fill), color: const Color(0xFFEF4444)),
                        const SizedBox(height: 8),
                        Text(
                          'Critical Gap',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: const Color(0xFFB91C1C),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Focus on REST APIs',
                          style: GoogleFonts.outfit(
                            fontSize: 16,
                            color: const Color(0xFF7F1D1D),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFECFEFF), // Soft Cyan
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFA5F3FC)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(PhosphorIcons.rocketLaunch(PhosphorIconsStyle.fill), color: const Color(0xFF06B6D4)),
                        const SizedBox(height: 8),
                        Text(
                          'Next Step',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: const Color(0xFF0E7490),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Node.js Basics',
                          style: GoogleFonts.outfit(
                            fontSize: 16,
                            color: const Color(0xFF164E63),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 32),
            
            // Detailed Breakdown
            Text(
              'Detailed Breakdown',
              style: GoogleFonts.outfit(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 16),
            
            // Skill List
            _buildSkillCard(
              skillName: 'REST APIs',
              currentLevel: 1.0,
              targetLevel: 5.0,
              priorityText: 'High Priority',
              priorityColor: const Color(0xFFEF4444),
              priorityBg: const Color(0xFFFEF2F2),
              growthHint: '80% growth needed',
            ),
            const SizedBox(height: 12),
            _buildSkillCard(
              skillName: 'Backend (Node.js)',
              currentLevel: 2.0,
              targetLevel: 4.5,
              priorityText: 'Medium Priority',
              priorityColor: const Color(0xFFF59E0B),
              priorityBg: const Color(0xFFFFFBEB),
              growthHint: '50% growth needed',
            ),
            const SizedBox(height: 12),
            _buildSkillCard(
              skillName: 'Cloud Services',
              currentLevel: 2.0,
              targetLevel: 4.0,
              priorityText: 'Medium Priority',
              priorityColor: const Color(0xFFF59E0B),
              priorityBg: const Color(0xFFFFFBEB),
              growthHint: '40% growth needed',
            ),
            
            const SizedBox(height: 32),
            
            // Generate Roadmap CTA
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: () {
                  context.go('/dashboard');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B82F6), // Blue
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Generate Learning Roadmap',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(PhosphorIcons.arrowRight()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkillCard({
    required String skillName,
    required double currentLevel,
    required double targetLevel,
    required String priorityText,
    required Color priorityColor,
    required Color priorityBg,
    required String growthHint,
  }) {
    // Current vs Target percentage representations (assuming out of 5)
    double currentPct = (currentLevel / 5.0);
    double targetPct = (targetLevel / 5.0);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                skillName,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: const Color(0xFF1E293B),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: priorityBg,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  priorityText,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 10,
                    color: priorityColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Stack the progress bars
          Stack(
            children: [
              // Target Bar (Background, Grey)
              Container(
                height: 8,
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9), // Light grey base
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              FractionallySizedBox(
                widthFactor: targetPct,
                child: Container(
                  height: 8,
                  decoration: BoxDecoration(
                    color: const Color(0xFFCBD5E1), // Target grey
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              // Current Bar (Foreground, Blue)
              FractionallySizedBox(
                widthFactor: currentPct,
                child: Container(
                  height: 8,
                  decoration: BoxDecoration(
                    color: const Color(0xFF3B82F6), // Current Blue
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${(currentPct * 100).toInt()}% current vs ${(targetPct * 100).toInt()}% target',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: const Color(0xFF64748B),
                ),
              ),
              Row(
                children: [
                  Icon(PhosphorIcons.trendUp(), color: const Color(0xFF06B6D4), size: 14),
                  const SizedBox(width: 4),
                  Text(
                    growthHint,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: const Color(0xFF06B6D4),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
