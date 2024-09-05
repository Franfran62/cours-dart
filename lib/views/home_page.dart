import 'package:cours_flutter/base/base_scaffold.dart';
import 'package:cours_flutter/widgets/pizza_card.dart';
import 'package:cours_flutter/providers/CartProvider.dart';
import 'package:flutter/material.dart';
import 'package:cours_flutter/constants/bdd.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key});

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    final cart = ref.watch(cartProvider);

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
                    children: pizzas.map((pizza) =>
                        PizzaCard(pizza: pizza))
                        .toList(),
                  ),
                  Container(
                    width: 80,
                    padding: EdgeInsets.only(top: 20),
                    child: ElevatedButton(
                        onPressed: () {  print("un jour, tu seras redirigé vers le panier"); },
                        child: Row(
                          children: [
                            Text(cart.length.toString()),
                            const Icon(Icons.shopping_cart),
                          ]
                        ),
                    ),
                  ),
                ],
          ),
    );
  }
}
