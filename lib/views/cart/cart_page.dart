import 'package:cours_flutter/base/base_scaffold.dart';
import 'package:cours_flutter/providers/cart_provider.dart';
import 'package:cours_flutter/views/cart/widgets/cart_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class CartPage extends ConsumerWidget {

  const CartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartAsyncValue = ref.watch(cartStreamProvider);

    return Basescaffold(
      body: cartAsyncValue.when(
        data: (data) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            shrinkWrap: true, 
            children: data.map((product) => CartCard(product: product)).toList(),
          ),
        ),
        error: (err, stack) => Container(),
        loading: () => const CircularProgressIndicator(),
      ),
    );
  }
}
