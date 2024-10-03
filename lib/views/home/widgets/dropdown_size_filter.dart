import 'package:cours_flutter/providers/pizza_provider.dart';
import 'package:cours_flutter/models/enums/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DropDownSizeFilter extends HookConsumerWidget {
  const DropDownSizeFilter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedSize = useState<Size?>(null);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          DropdownButton<Size>(
            value: selectedSize.value,
            onChanged: (Size? choice) async {
              final error = await ref.read(pizzaProviderNotifier.notifier).filterBySize(size: choice);
              if (error != null) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
              }
              selectedSize.value = choice;
            },
            hint: const Text("Filtrez par taille"),
            items: [
              const DropdownMenuItem(
                value: null,
                child: Text("Toutes les tailles")
                ),
              ...Size.values.map((Size el) {
              return DropdownMenuItem<Size>(
                value: el,
                child: Text(el.name.toString()),
              );
            }),
            ]
          ),
        ],
      ),
    );
  }
}
