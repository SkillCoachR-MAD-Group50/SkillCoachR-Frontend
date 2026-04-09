import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_service.g.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      if (user != null) {
        // Save initial user profile data to Firestore
        await _firestore.collection('users').doc(user.uid).set({
          'name': name,
          'email': email,
          'profileCompleted': false,
          'createdAt': FieldValue.serverTimestamp(),
        });
        
        // Optionally update display name in Firebase Auth
        await user.updateDisplayName(name);
        
        // Per user request: Force sign out so they must manually log in next
        await _firebaseAuth.signOut();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> login({required String email, required String password}) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      if (user != null) {
        // Get JWT token as per user requirement, store in SharedPreferences
        final token = await user.getIdToken();
        if (token != null) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('jwt_token', token);
        }

        // Fetch user document from Firestore to check profile completion status
        final doc = await _firestore.collection('users').doc(user.uid).get();
        if (doc.exists) {
          final data = doc.data() as Map<String, dynamic>;
          final profileCompleted = data['profileCompleted'] as bool? ?? false;
          return profileCompleted;
        }
      }
      return false; // Default if doc doesn't exist
    } catch (e) {
      rethrow;
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('jwt_token');
    } catch (e) {
      rethrow;
    }
  }

  Future<void> completeProfile() async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).update({
          'profileCompleted': true,
        });
      }
    } catch (e) {
      debugPrint('Error updating profile completion: $e');
    }
  }
}

@riverpod
AuthService authService(AuthServiceRef ref) {
  return AuthService();
}
