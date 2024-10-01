import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cours_flutter/models/pizza.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Stream collectionStream = FirebaseFirestore.instance.collection('pizza').snapshots();

final pizzaProvider = StreamProvider.autoDispose<List<Pizza>>((ref) {
  return FirebaseFirestore.instance
      .collection('pizza')
      .get().asStream()
      .map((snapshot) => snapshot.docs.map((doc) => Pizza.fromQueryDocumentSnapshot(doc)).toList());
});


