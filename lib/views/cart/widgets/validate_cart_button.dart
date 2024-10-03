import 'package:cours_flutter/models/command_user.dart';
import 'package:cours_flutter/models/enums/paiement_type.dart';
import 'package:cours_flutter/models/product.dart';
import 'package:cours_flutter/models/user.dart' as app;
import 'package:cours_flutter/providers/command_provider.dart';
import 'package:cours_flutter/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ValidateCartButton extends StatelessWidget {
  final List<Product> listOfProduct;
  final PaiementType paiementType;
  final WidgetRef ref;

  const ValidateCartButton(
      {super.key,
      required this.listOfProduct,
      required this.ref,
      required this.paiementType});

  setCommandUser() async {
    final app.User? userLinked = ref.read(userNotifier);
    if (userLinked != null) {
      final commandUser = CommandUser(
          userLinked: userLinked,
          products: listOfProduct,
          total: listOfProduct.fold(0,
              (previousValue, product) => previousValue + product.totalPrice),
          paiementType: paiementType);
          
    await ref.read(commandStreamProvider.notifier).add(commandUser: commandUser);
    }

  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () => setCommandUser(), child: const Text('Valider le panier'));
  }
}
