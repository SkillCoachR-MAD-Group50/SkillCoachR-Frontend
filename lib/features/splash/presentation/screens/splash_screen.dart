import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  bool _animationCompleted = false;
  bool _authResolved = false;
  bool _isLoggedIn = false;
  bool _profileCompleted = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 1.0, curve: Curves.easeIn),
      ),
    );

    _controller.forward();

    _checkAuthState();

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _animationCompleted = true;
        });
        _navigateIfReady();
      }
    });
  }

  Future<void> _checkAuthState() async {
    try {
      final user = await FirebaseAuth.instance.authStateChanges().first;
      if (user != null) {
        final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
        if (doc.exists) {
          final data = doc.data() as Map<String, dynamic>;
          _profileCompleted = data['profileCompleted'] as bool? ?? false;
        }
      }
      
      if (mounted) {
        setState(() {
          _isLoggedIn = user != null;
          _authResolved = true;
        });
        _navigateIfReady();
      }
    } catch (e) {
      debugPrint('Auth check error: $e');
      if (mounted) {
        setState(() {
          _isLoggedIn = false;
          _authResolved = true;
        });
        _navigateIfReady();
      }
    }
  }

  void _navigateIfReady() async {
    if (_animationCompleted && _authResolved) {
      if (_isLoggedIn) {
        context.go('/');
      } else {
        context.go('/login');
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.bgGradient,
        ),
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: Opacity(
                  opacity: _opacityAnimation.value,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/images/logo.png',
                        width: 300,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Coach your skills. Master your future.',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: AppTheme.textSecondary,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1.2,
                            ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
