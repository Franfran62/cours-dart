import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cours_flutter/providers/firebase_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cours_flutter/models/user.dart' as app;

final userProvider = StateProvider<app.User?>((ref) => null);

final userNotifier = StateNotifierProvider<UserNotifier, app.User?>((ref) => UserNotifier(ref));

class UserNotifier extends StateNotifier<app.User?> {
  Ref ref;
  UserNotifier(this.ref) : super(null);

  Future<bool> registerInFirebase({required app.User user}) async {
    await ref.read(firebaseNotifier.notifier).register(user: user).then((value) async {
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
    return await ref.read(firebaseNotifier.notifier).login(email: email, password: password).then(
        (userCredential) async {
      if (userCredential != null && userCredential.user != null) {
        return await FirebaseFirestore.instance.collection('user').where('email', isEqualTo: email).get().then(
            (snapshot) {
          if (snapshot.docs.isNotEmpty) {
            state = app.User.fromQueryDocumentSnapshot(snapshot.docs.first);
            return true;
          }
          return false;
        }, onError: (error) => false);
      }
      return false;
    }, onError: (error) => false);
  }
}
