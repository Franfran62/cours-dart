import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cours_flutter/base/base_scaffold.dart';
import 'package:cours_flutter/models/pizza.dart';
import 'package:cours_flutter/widgets/pizza_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key});

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final cartStream = FirebaseFirestore.instance.collection('cart').snapshots();
    final pizzaStream = FirebaseFirestore.instance.collection('pizzas').get();

    return FutureBuilder(
        future: pizzaStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasData) {
            final firebasePizzas = snapshot.data!.docs;
            return Basescaffold(
              body: Column(
                children: [
                  // Wrap(
                  //   spacing: 8.0,
                  //   children: ingredients.map((ingredient) {
                  //     return FilterChip(
                  //       label: Text(ingredient.name),
                  //       onSelected: (bool selected) {
                  //         ref.watch(pizzaProvider.notifier).filterByIngredient(
                  //             ingredient, selected);
                  //       },
                  //     );
                  //   }).toList(),
                  // ),
                  ListView(
                      shrinkWrap: true,
                      children: firebasePizzas.map((doc) {
                        final pizza = Pizza.fromQueryDocumentSnapshot(doc);
                        return PizzaCard(pizza: pizza);
                      }).toList()),
                  Container(
                    width: 80,
                    padding: const EdgeInsets.only(top: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/panier');
                      },
                      child: Row(children: [
                        Expanded(
                          child: StreamBuilder(
                              stream: cartStream,
                              builder: (context, snapshot) {
                                if (snapshot.hasError ||
                                    snapshot.connectionState == ConnectionState.done && snapshot.data == null) {
                                  return const Text('0');
                                }
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return const CircularProgressIndicator();
                                } else {
                                  final cart = snapshot.data!.docs;
                                  return Text(cart
                                      .fold<double>(0, (previousValue, product) => previousValue + product['quantity'])
                                      .toInt()
                                      .toString());
                                }
                              }),
                        ),
                        const Icon(Icons.shopping_cart, size: 20),
                      ]),
                    ),
                  ),
                ],
              ),
            );
          }
          return Basescaffold(body: Text('Error'));
        });
  }
}
