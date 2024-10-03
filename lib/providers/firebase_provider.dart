import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

  Future<UserCredential?> register({required String email, required String password}) async {
    try {
      return await state!.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<UserCredential?> registerWithGoogle({required GoogleSignInAccount googleUser}) async {
    try {
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
     return await state!.signInWithCredential(credential);
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
