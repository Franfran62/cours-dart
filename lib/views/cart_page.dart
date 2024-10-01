import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cours_flutter/models/product.dart';
import 'package:cours_flutter/providers/CartProvider.dart';
import 'package:cours_flutter/widgets/panier_card.dart';
import 'package:cours_flutter/widgets/pizza_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartPageState extends ConsumerState {
  @override
  Widget build(BuildContext context) {
    final cartAsyncValue = ref.watch(cartStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Panier'),
      ),
      body: cartAsyncValue.when(
        data: (data) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(shrinkWrap: true, children: data.map((pizza) => PizzaCard(pizza: pizza)).toList()),
        ),
        error: (err, stack) => Container(),
        loading: () => CircularProgressIndicator(),
      ),
    );
  }
}
