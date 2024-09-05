
import 'package:cours_flutter/models/pizza.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cartProvider = StateNotifierProvider<CartNotifier, List<Pizza>>((ref) {
  return CartNotifier();
});

class CartNotifier extends StateNotifier<List<Pizza>> {
  CartNotifier() : super([]);

  Future<void> initialize() async {
    state = [];
  }

  Future<void> addPizza(Pizza pizza) async {
    state.add(pizza);
    state = List.from(state);
  }

  Future<void> removePizza(Pizza pizza) async {
    state.remove(pizza);
    state = List.from(state);
  }

  num get totalPrice {
    return state.fold(0, (sum, pizza) => sum + pizza.price);
  }
}