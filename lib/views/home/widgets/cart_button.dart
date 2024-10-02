import 'package:cours_flutter/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CartButton extends ConsumerWidget {

  const CartButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartAsyncValue = ref.watch(cartStreamProvider);

    return cartAsyncValue.when(
      data: (data) => Row(
        children: [
          ElevatedButton(
              onPressed: () => GoRouter.of(context).go("/panier"),
              child: Row(
                children: [
                  Text(data
                          .fold<double>(0, (previousValue, product) => previousValue + product.quantity)
                          .toInt()
                          .toString()
                    ),
                  const Icon( Icons.shopping_cart, size: 20),
                ],
              ),
            ),
        ],
      ),
      error: (err, stack) => const Text("Oops"), 
      loading: () => const Text("load"),
      );
    }
}
