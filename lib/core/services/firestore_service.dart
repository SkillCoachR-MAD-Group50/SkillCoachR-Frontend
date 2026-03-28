import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'firestore_service.g.dart';

@riverpod
class FirestoreService extends _$FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  void build() {}

  Future<void> createUserProfile(String uid, String email) async {
    final userRef = _db.collection('users').doc(uid);
    final doc = await userRef.get();

    if (!doc.exists) {
      await userRef.set({
        'uid': uid,
        'email': email,
        'createdAt': FieldValue.serverTimestamp(),
        'hasCompletedSetup': false,
      });
    }
  }

  Future<bool> hasCompletedSetup(String uid) async {
    final doc = await _db.collection('users').doc(uid).get();
    return doc.data()?['hasCompletedSetup'] ?? false;
  }
}
