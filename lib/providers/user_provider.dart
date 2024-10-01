import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cours_flutter/models/user.dart' as app;

final firebaseUser = StateProvider<User?>((ref) => null);

final userProvider =
    StateNotifierProvider<UserProvider, FirebaseAuth?>((ref) => UserProvider(ref));


class UserProvider extends StateNotifier<FirebaseAuth?>{

  Ref ref;
  UserProvider(this.ref) : super(null);

    Future<void> initialize() async {
      state = FirebaseAuth.instance;
      if (state != null) {
        state!.authStateChanges().listen(
         (User? user) {
            if (user == null) {
              ref.read(firebaseUser.notifier).state = null;
            } else {
              ref.read(firebaseUser.notifier).state = user;
            }
          },
        );
      }
    }

    Future<bool> register({required app.User user}) async {
      try {
        await state!.createUserWithEmailAndPassword(
              email: user.email,
              password: user.password,
            );
        return true;
      } on FirebaseAuthException catch (e) {
        print(e.message);
      }
      return false;
    }

    Future<bool> logout() async {
      try {
        await state!.signOut();
        ref.read(firebaseUser.notifier).state = null;
        return true;
      } on FirebaseAuthException catch (e) {
        print(e.message);
      }
      return false;
    }

    Future<bool> login({required String email, required String password}) async {
      try {
        await state!.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        return true;
      } on FirebaseAuthException catch (e) {
        print(e.message);
      }
      return false;
    }
}
