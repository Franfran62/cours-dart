import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cours_flutter/models/product.dart';
import 'package:cours_flutter/providers/CartProvider.dart';
import 'package:cours_flutter/widgets/panier_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartPage extends ConsumerStatefulWidget {
  const CartPage({super.key});
  
  @override
  ConsumerState<CartPage> createState() => _CartPageState();
}

class _CartPageState extends ConsumerState<CartPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Stream<QuerySnapshot> cartStream = FirebaseFirestore.instance.collection('cart').snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: cartStream,
      builder: (context, snapshot) {
          if (snapshot.hasError || snapshot.data == null) {
            return const Text('Erreur');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else {
          final cart = snapshot.data!.docs;
          return Scaffold(
            appBar: AppBar(
              title: const Text('Panier'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child:  ListView(
                shrinkWrap: true,
                children: 
                  cart.map<Widget>((doc) {
                      final product = Product.fromQueryDocumentSnapshot(doc);
                      return PanierCard(product: product);
                    }).toList()
              )
            ),
          );
      }
      }
    );
  }
}
