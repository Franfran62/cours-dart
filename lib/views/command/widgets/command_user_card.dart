import 'package:cours_flutter/models/command_user.dart';
import 'package:flutter/material.dart';

class CommandUserCard extends StatelessWidget {

  final CommandUser commandUser;

  const CommandUserCard({required this.commandUser});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(commandUser.products.map((product) => "${product.quantity} ${product.name} taille ${product.size.getAcronyme()}" ).join(", "),
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                maxLines: 2,),
              ],
            ),
            Text(commandUser.total.toString()),
            Text(commandUser.paiementType.name ?? ""),
          ],
        ),
      ),
    );
  }
}