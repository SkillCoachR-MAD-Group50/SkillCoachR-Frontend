import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart' as gsi;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'firestore_service.dart';

part 'auth_service.g.dart';

@riverpod
class AuthService extends _$AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final gsi.GoogleSignIn _googleSignIn = gsi.GoogleSignIn();

  @override
  Stream<User?> build() {
    return _auth.authStateChanges();
  }

  Future<UserCredential> signInWithEmailAndPassword(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      if (credential.user != null) {
        await ref.read(firestoreServiceProvider.notifier).createUserProfile(
          credential.user!.uid,
          credential.user!.email ?? '',
        );
      }
      return credential;
    } on FirebaseAuthException {
      rethrow;
    }
  }

  Future<UserCredential> signUpWithEmailAndPassword(String email, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      if (credential.user != null) {
        await ref.read(firestoreServiceProvider.notifier).createUserProfile(
          credential.user!.uid,
          credential.user!.email ?? '',
        );
      }
      return credential;
    } on FirebaseAuthException {
      rethrow;
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final gsi.GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final gsi.GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final result = await _auth.signInWithCredential(credential);
      if (result.user != null) {
        await ref.read(firestoreServiceProvider.notifier).createUserProfile(
          result.user!.uid,
          result.user!.email ?? '',
        );
      }
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    await Future.wait([
      _auth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }
}
