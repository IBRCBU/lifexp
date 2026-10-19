import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lifexp_app/features/auth/domain/models/app_user.dart';

class AuthRepository {
  AuthRepository({required this.auth, required this.firestore});

  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  Stream<User?> get authStateChanges => auth.authStateChanges();
  User? get currentUser => auth.currentUser;

  Future<UserCredential> register({
    required String name,
    required String email,
    required String password,
    required AppRole role,
  }) async {
    final credential = await auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
    final user = credential.user;
    if (user == null) {
      throw StateError('Firebase did not return the newly created account.');
    }

    try {
      await user.updateDisplayName(name.trim());
      final profile = AppUser(
        userId: user.uid,
        name: name.trim(),
        email: email.trim(),
        role: role,
        createdAt: DateTime.now(),
      );
      await firestore.collection('users').doc(user.uid).set(profile.toMap());
      return credential;
    } catch (_) {
      await user.delete();
      rethrow;
    }
  }

  Future<UserCredential> signIn({required String email, required String password}) async {
    final credential = await auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
    final user = credential.user;
    if (user == null) {
      throw StateError('Firebase did not return the signed-in account.');
    }

    final profile = await getProfile(user.uid);
    if (profile == null || profile.isDisabled) {
      await auth.signOut();
      throw FirebaseAuthException(
        code: profile == null ? 'profile-not-found' : 'user-disabled',
        message: profile == null
            ? 'This account has no LifeXP profile.'
            : 'This account has been disabled.',
      );
    }
    return credential;
  }

  Future<void> sendPasswordReset(String email) =>
        auth.sendPasswordResetEmail(email: email.trim());

      Future<void> signOut() => auth.signOut();

  Future<AppUser?> getProfile(String userId) async {
    final snapshot = await firestore.collection('users').doc(userId).get();
    final data = snapshot.data();
    return data == null ? null : AppUser.fromMap(data);
  }

  Future<bool> updateProfile({
    required String name,
    required String email,
    required String avatar,
    String? currentPassword,
  }) async {
    final user = auth.currentUser;
    if (user == null) throw StateError('No signed-in account is available.');

    final normalizedEmail = email.trim();
    if (normalizedEmail != user.email) {
      if (currentPassword == null || currentPassword.isEmpty || user.email == null) {
        throw FirebaseAuthException(
          code: 'requires-recent-login',
          message: 'Enter your current password to change your email address.',
        );
      }
      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: currentPassword,
      );
      await user.reauthenticateWithCredential(credential);
      await user.verifyBeforeUpdateEmail(normalizedEmail);
    }

    await user.updateDisplayName(name.trim());
    await firestore.collection('users').doc(user.uid).update({
      'name': name.trim(),
      'avatar': avatar,
    });
    return normalizedEmail != user.email;
  }
}