import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cours_flutter/models/user.dart' as app;

final firebaseProvider = StateProvider<User?>((ref) => null);

final firebaseNotifier = StateNotifierProvider<FirebaseProvider, FirebaseAuth?>(
    (ref) => FirebaseProvider(ref));

class FirebaseProvider extends StateNotifier<FirebaseAuth?> {
  Ref ref;
  FirebaseProvider(this.ref) : super(null);

  Future<void> initialize() async {
    state = FirebaseAuth.instance;
    if (state != null) {
      state!.authStateChanges().listen(
        (User? user) {
          if (user == null) {
            ref.read(firebaseProvider.notifier).state = null;
          } else {
            ref.read(firebaseProvider.notifier).state = user;
          }
        },
      );
    }
  }

  Future<UserCredential?> register({required app.User user}) async {
    try {
      return await state!.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<bool> logout() async {
    try {
      await state!.signOut();
      ref.read(firebaseProvider.notifier).state = null;
      return true;
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
    return false;
  }

  Future<UserCredential?> login(
      {required String email, required String password}) async {
    try {
     return await state!.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
    return null;
  }
}
