import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cours_flutter/providers/firebase_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cours_flutter/models/user.dart' as app;

final userProvider = StateProvider<app.User?>((ref) => null);

final userNotifier = StateNotifierProvider<UserNotifier, app.User?>((ref) => UserNotifier(ref));

class UserNotifier extends StateNotifier<app.User?> {
  Ref ref;
  UserNotifier(this.ref) : super(null);

  Future<bool> registerInFirebase({required app.User user, required String email, required String password}) async {
    await ref.read(firebaseNotifier.notifier).register(email: email, password: password).then((value) async {
      if (value != null && value.user != null) {
        user.id = value.user!.uid;
        await createNewUser(user: user);
        return true;
      }
    }, onError: (error) => false);
    return false;
  }

  Future<void> createNewUser({required app.User user}) async {
    try {
      await FirebaseFirestore.instance.collection('user').doc(user.id).set(user.toSnapshot());
      state = user;
    } catch (e) {
      print(e);
    }
  }

  Future<bool> loginInFirebase({required String email, required String password}) async {
    try {
      final userCredential = await ref.read(firebaseNotifier.notifier).login(email: email, password: password);
      if (userCredential != null && userCredential.user != null) {
        final snapshot = await FirebaseFirestore.instance.collection('user').doc(userCredential.user!.uid).get();
        if (snapshot.exists) {
          state = app.User.fromSnapshot(snapshot.data()!);
          print(state);
          return true;
        }
      }
    } catch (error) {
      print(error.toString());
    }
    return false;
  }

  Future<bool> logoutFromFirebase() async {
    try {
      await ref.read(firebaseNotifier.notifier).logout();
      state = null;
      return true;
    } catch (error) {
      print(error);
    }
    return false;
  }
}
