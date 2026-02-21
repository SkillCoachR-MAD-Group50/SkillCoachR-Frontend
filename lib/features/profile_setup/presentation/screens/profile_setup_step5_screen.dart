import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:go_router/go_router.dart';

class ProfileSetupStep5Screen extends StatefulWidget {
  const ProfileSetupStep5Screen({super.key});

  @override
  State<ProfileSetupStep5Screen> createState() => _ProfileSetupStep5ScreenState();
}

class _ProfileSetupStep5ScreenState extends State<ProfileSetupStep5Screen> {
  double _hoursPerWeek = 5;

  String get _intensityLevel {
    if (_hoursPerWeek <= 5) return 'Light';
    if (_hoursPerWeek <= 15) return 'Moderate';
    return 'Intensive';
  }

  void _setHours(double hours) {
    setState(() {
      _hoursPerWeek = hours;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Roughly 1 hour per day = 7 hours per week
    int dailyEstimate = (_hoursPerWeek / 7).round();
    if (dailyEstimate < 1 && _hoursPerWeek > 0) dailyEstimate = 1;

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
                          'Setup Your Profile',
                          style: GoogleFonts.outfit(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF1E293B),
                          ),
                        ),
                        Text(
                          'Step 5 of 5',
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
                    color: Color(0xFFFFF7ED), // Light orange background for icon
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    PhosphorIcons.clock(),
                    color: const Color(0xFFF59E0B), // Orange/amber icon top right
                    size: 24,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Segmented Progress Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Row(
              children: List.generate(5, (index) {
                return Expanded(
                  child: Container(
                    height: 4,
                    margin: EdgeInsets.only(right: index < 4 ? 6.0 : 0),
                    decoration: BoxDecoration(
                      color: const Color(0xFF00C7D4), // All 5 steps are active (Teal)
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 24),
          
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // AI Coach Banner
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF4F9FF),
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
                          child: Icon(PhosphorIcons.sparkle(PhosphorIconsStyle.fill), color: Colors.white, size: 24),
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
                                "Setting realistic time commitments leads to better results!",
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
                  
                  const SizedBox(height: 40),
                  
                  // Center Avatar Section
                  Container(
                    width: 96,
                    height: 96,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFFFF0D4), // Light orange background for big center icon
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      PhosphorIcons.clock(),
                      size: 48,
                      color: const Color(0xFFEAB308), // Yellowish/amber clock icon
                    ),
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // Interactive Slider Section
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "How many hours per week can you learn?",
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Slider
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: const Color(0xFF1E3A8A), // Dark blue active track
                      inactiveTrackColor: const Color(0xFFF1F5F9), // Light grey inactive track
                      trackHeight: 12.0,
                      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12.0),
                      thumbColor: Colors.white,
                      overlayColor: const Color(0xFF1E3A8A).withOpacity(0.2),
                      activeTickMarkColor: Colors.transparent,
                      inactiveTickMarkColor: Colors.transparent,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ]
                      ),
                      child: Slider(
                        value: _hoursPerWeek,
                        min: 1,
                        max: 40,
                        divisions: 39,
                        onChanged: (value) {
                          setState(() {
                            _hoursPerWeek = value;
                          });
                        },
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Dynamic Large Selection Card
                  Container(
                    width: 200,
                    padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF7ED), // Light orange background
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFFFEDD5)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          _hoursPerWeek.round().toString(),
                          style: GoogleFonts.outfit(
                            fontSize: 56,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFFF97316), // Orange text
                            height: 1.0,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'hours per week',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: const Color(0xFF64748B),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '≈ $dailyEstimate hours per\nday',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: const Color(0xFF94A3B8),
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Intensity Selection Cards
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildIntensityCard('Light', '1-5 hrs', 3),
                      const SizedBox(width: 8),
                      _buildIntensityCard('Moderate', '5-15 hrs', 10),
                      const SizedBox(width: 8),
                      _buildIntensityCard('Intensive', '15+ hrs', 20),
                    ],
                  ),
                  
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
          
          // Bottom Navigation Button
          Container(
            padding: const EdgeInsets.all(24.0),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Color(0xFFF1F5F9))),
            ),
            child: SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: () {
                  context.pushNamed('assessment');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3265D6), // match screenshot button shade
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Complete Setup', // Changed from Next
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIntensityCard(String title, String subtitle, double targetHours) {
    final isSelected = _intensityLevel == title;
    
    return Expanded(
      child: GestureDetector(
        onTap: () => _setHours(targetHours),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFE6FFFA) : const Color(0xFFF8FAFC), // Teal tint if selected, soft grey if not
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? const Color(0xFFCCFBF1) : Colors.transparent,
            ),
          ),
          child: Column(
            children: [
              Text(
                title,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: const Color(0xFF64748B),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
