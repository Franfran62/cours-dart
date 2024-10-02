import 'package:cours_flutter/models/pizza.dart';
import 'package:cours_flutter/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PizzaCard extends ConsumerWidget {
  final Pizza pizza;
  const PizzaCard({super.key, required this.pizza});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.80,
      height: MediaQuery.of(context).size.height / 6,
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Row(
          children: [
            SizedBox(
                height: MediaQuery.of(context).size.height,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image(image: AssetImage(pizza.image), fit: BoxFit.fitHeight),
                )),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, top: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pizza.name,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                      maxLines: 1,
                    ),
                    Text(
                      "${pizza.price}€",
                      style: const TextStyle(fontSize: 18),
                    )
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                  onPressed: () => ref.watch(cartStreamProvider.notifier).add(pizza),
                  style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll<Color>(Colors.orangeAccent),
                  ),
                  child: const Row(
                    children: [Text("Add "), Icon(Icons.add)],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

// child:
