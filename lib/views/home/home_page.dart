import 'dart:math';

import 'package:cours_flutter/base/base_scaffold.dart';
import 'package:cours_flutter/providers/pizza_provider.dart';
import 'package:cours_flutter/views/home/widgets/cart_button.dart';
import 'package:cours_flutter/views/home/widgets/dropdown_size_filter.dart';
import 'package:cours_flutter/views/home/widgets/pizza_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pizzasList = ref.watch(pizzaProviderNotifier);

    return Basescaffold(
        body: ref.watch(loadingProvider)
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 40, bottom: 20),
                      child: Text(
                        "Nos pizzas",
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                      ),
                    ),
                    const DropDownSizeFilter(),
                    pizzasList.isNotEmpty
                        ? ListView(
                            shrinkWrap: true,
                            children: pizzasList.map((pizza) => PizzaCard(pizza: pizza)).toList(),
                          )
                        : const Text('Aucune pizza trouvée'),
                    const CartButton(),
                  ],
                ),
              ));
  }
}
