import 'package:cours_flutter/models/product.dart';
import 'package:cours_flutter/providers/CartProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cours_flutter/providers/CartProvider.dart';

class PanierCard extends ConsumerWidget {
  final Product product;

  const PanierCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(5),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  product.size.name,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      'Quantité: ${product.quantity}',
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    IconButton(
                        onPressed: () => ref.read(cartProvider.notifier).remove(product), icon: Icon(Icons.remove))
                  ],
                ),
                Text(
                  '${product.totalPrice}€',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                IconButton(
                  onPressed: () => ref.read(cartProvider.notifier).remove(product), 
                  icon: const Icon(Icons.remove_circle_outline),
                  ),

                
              ],
            ),
          ],
        ),
      ),
    );
  }
}
