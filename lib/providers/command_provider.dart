import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cours_flutter/models/command_user.dart';
import 'package:cours_flutter/models/user.dart' as app;
import 'package:flutter_riverpod/flutter_riverpod.dart';

final commandStreamProvider =
    StreamNotifierProvider<CommandStreamNotifier, List<CommandUser>>(
        CommandStreamNotifier.new);

class CommandStreamNotifier extends StreamNotifier<List<CommandUser>> {

  @override
  Stream<List<CommandUser>> build() {
    return FirebaseFirestore.instance.collection('command').snapshots().map(
        (snapshot) => snapshot.docs
            .map((doc) => CommandUser.fromQueryDocumentSnapshot(doc))
            .toList());
  }

  Future<void> add({required CommandUser commandUser}) async {
    if (await ifCommandUserAlreadyExists(userLinked: commandUser.userLinked)) {
      await FirebaseFirestore.instance
          .collection('command')
          .add(commandUser.toSnapshot());
    }
    return;
  }

  Future<bool> ifCommandUserAlreadyExists({required app.User userLinked}) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('command')
        .where('userLinked.id', isEqualTo: userLinked.id)
        .get();

    return querySnapshot.docs.isEmpty;
  }
}
