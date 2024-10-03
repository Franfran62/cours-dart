import 'package:cours_flutter/base/base_scaffold.dart';
import 'package:cours_flutter/models/enums/paiement_type.dart';
import 'package:cours_flutter/providers/cart_provider.dart';
import 'package:cours_flutter/views/cart/widgets/validate_cart_button.dart';
import 'package:cours_flutter/views/cart/widgets/cart_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CartPage extends HookConsumerWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final cartAsyncValue = ref.watch(cartStreamProvider);
    final selectedPaiementType = useState<PaiementType?>(null);

    return Basescaffold(
      body: cartAsyncValue.when(
        data: (data) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ListView(
                shrinkWrap: true,
                children:
                    data.map((product) => CartCard(product: product)).toList(),
              ),
              DropdownButton<PaiementType>(
                hint: const Text('Selectionnez votre moyen de paiement'),
                value: selectedPaiementType.value,
                onChanged: (PaiementType? newValue) {
                    selectedPaiementType.value = newValue;
                },
                items: PaiementType.values
                    .where((type) => type != PaiementType.nondit)
                    .map((type) => DropdownMenuItem<PaiementType>(
                      value: type,
                      child: Text(type.getName()),
                    ))
                    .toList(),
              ),
              ValidateCartButton(
                  listOfProduct: data, 
                  ref: ref,
                  paiementType: selectedPaiementType.value ?? PaiementType.nondit),
            ],
          ),
        ),
        error: (err, stack) => Container(),
        loading: () => const CircularProgressIndicator(),
      ),
    );
  }
}
