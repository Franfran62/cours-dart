import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cours_flutter/models/enums/size.dart';
import 'package:cours_flutter/models/pizza.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Stream collectionStream = FirebaseFirestore.instance.collection('pizza').snapshots();

final pizzaProvider = StreamProvider.autoDispose<List<Pizza>>((ref) {
  return FirebaseFirestore.instance
      .collection('pizza')
      .get().asStream()
      .map((snapshot) => snapshot.docs.map((doc) => Pizza.fromQueryDocumentSnapshot(doc)).toList());
});

final pizzaNotifier = StateNotifierProvider<PizzaNotifier, AsyncValue<List<Pizza>>>((ref) {
  return PizzaNotifier();
});


class PizzaNotifier extends StateNotifier<AsyncValue<List<Pizza>>> {

  PizzaNotifier() : super(const AsyncValue.loading()) {
    loadPizzas();
  }

  Future<void> loadPizzas() async {
    try {
      final snapshot = await FirebaseFirestore.instance.collection('pizza').get();
      state = AsyncValue.data(snapshot.docs.map((doc) => Pizza.fromQueryDocumentSnapshot(doc)).toList());
    } catch (e) {
      state = AsyncValue.error(e.toString(), StackTrace.current);
    }
  }
  Future<void> filterBySize({Size? size}) async {
    try {
      QuerySnapshot snapshot;
      if (size == null) {
        snapshot = await FirebaseFirestore.instance.collection('pizza').get();
      } else {
        snapshot = await FirebaseFirestore.instance.collection('pizza')
                                                        .where('size', 
                                                        isEqualTo: size.toString().split('.').last).get();
      }
      state = AsyncValue.data(snapshot.docs.map((doc) => Pizza.fromQueryDocumentSnapshot(doc)).toList());
    } catch (e) {
      state = AsyncValue.error(e.toString(), StackTrace.current);
    }
  }
}



