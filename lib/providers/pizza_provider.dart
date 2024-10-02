import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cours_flutter/models/enums/size.dart';
import 'package:cours_flutter/models/pizza.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loadingProvider = StateProvider<bool>((ref) => true);

final pizzaProviderNotifier = StateNotifierProvider<PizzaNotifier, List<Pizza>>((ref) => PizzaNotifier(ref));

class PizzaNotifier extends StateNotifier<List<Pizza>> {
  Ref ref;

  PizzaNotifier(this.ref) : super([]);

  Future<void> loadPizzas() async {
    FirebaseFirestore.instance.collection('pizza').get().then((snapshots) {
      state = List.from(
        snapshots.docs
            .map(
              (doc) => Pizza.fromQueryDocumentSnapshot(doc),
            )
            .toList(),
      );
      ref.read(loadingProvider.notifier).state = false;
    }, onError: (e) => print(e));
  }

  Future<String?> filterBySize({Size? size}) async {
    try {
      if (size == null) {
        loadPizzas();
      } else {
        await FirebaseFirestore.instance
            .collection('pizza')
            .where('size', isEqualTo: size.toString().split('.').last)
            .get()
            .then(
          (snapshots) {
            state = List.from(
              snapshots.docs
                  .map(
                    (doc) => Pizza.fromQueryDocumentSnapshot(doc),
                  )
                  .toList(),
            );
          },
        );
      }
    } catch (e) {
      return ("Quelque chose s'est mal passé");
    }
    return null;
  }
}
