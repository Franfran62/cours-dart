import 'dart:math';

import 'package:cours_flutter/base/base_scaffold.dart';
import 'package:cours_flutter/providers/pizza_provider.dart';
import 'package:cours_flutter/widgets/cart_button.dart';
import 'package:cours_flutter/widgets/pizza_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {

  const HomePage({super.key});

    @override
  Widget build(BuildContext context, WidgetRef ref) {

    final pizzaAsyncValue = ref.watch(pizzaProvider);

    return Basescaffold(
      body: pizzaAsyncValue.when(
          data: (data) => Column(
            children: [
              ListView(
                shrinkWrap: true,
                children: data.map((pizza) => PizzaCard(pizza: pizza)).toList(),
              ),
             const CartButton(),
            ],
          ), 
          error: (err, stack) => Text(err.toString()), 
          loading: () => const CircularProgressIndicator(),
        ),
    );
  }
}
