import 'package:cours_flutter/providers/pizza_provider.dart';
import 'package:cours_flutter/models/enums/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DropDownSizeFilter extends ConsumerStatefulWidget {

  const DropDownSizeFilter({
    super.key, 
  });

   @override
  DropDownSizeFilterState createState() => DropDownSizeFilterState();
}

class DropDownSizeFilterState extends ConsumerState<DropDownSizeFilter> {

  Size? selectedSize;

      getItems() {
        var response = List<DropdownMenuItem<Size>>.empty(growable: true);

        for (var value in Size.values) {
            response.add(DropdownMenuItem<Size>(
              value: value,
              child: Text(value.toString().split('.').last),
            )
          );
        }
    }

  @override
  Widget build(BuildContext context) {

    var items = getItems();

    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          DropdownButton<Size>(
            value: selectedSize,
            onChanged: (Size? choice) { 
              ref.read(pizzaNotifier.notifier).filterBySize(size: choice);
              setState(() {
                selectedSize = choice;
              });
              },
            hint: const Text("Filtrez par taille"),
            items: Size.values.map((Size el) { 
              return DropdownMenuItem<Size>(
                value: el,
                child: Text(el.name.toString()),
              );
            }
            ).toList(),
          ),
        ],
      ),
    );
  }
}