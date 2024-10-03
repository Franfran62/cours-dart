import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cours_flutter/models/pizza.dart';
import 'package:cours_flutter/models/product.dart';
import 'package:cours_flutter/providers/user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cartStreamProvider =
    StreamNotifierProvider<CartStreamNotifier, List<Product>>(
        CartStreamNotifier.new);

class CartStreamNotifier extends StreamNotifier<List<Product>> {

  @override
  Stream<List<Product>> build() {

    final String? userId = ref.read(userNotifier)!.id;

    return FirebaseFirestore.instance.collection('cart').doc(userId).collection("product").snapshots().map(
        (snapshot) => snapshot.docs
            .map((doc) => Product.fromQueryDocumentSnapshot(doc))
            .toList());
  }

  Future<void> add(Pizza pizza) async {
    Product product = Product.fromPizza(pizza: pizza);
    final String? userId = ref.read(userNotifier)!.id;

    Product? productAlreadyInCart = await alreadyInCart(product: product, userId: userId);
    if (productAlreadyInCart != null) {
      productAlreadyInCart.addQuantity(pizza.price);
      await FirebaseFirestore.instance
          .collection('cart')
          .doc(userId)
          .collection("product")
          .doc(productAlreadyInCart.id)
          .update(productAlreadyInCart.toSnapshot());
      return;
    } else {
      await FirebaseFirestore.instance
          .collection('cart')
          .doc(userId)
          .collection("product")
          .add(product.toSnapshot());
    }
  }

  Future<Product?> alreadyInCart({required Product product, required String? userId}) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('cart')
        .doc(userId)
        .collection("product")
        .where('name', isEqualTo: product.name)
        .where('size', isEqualTo: product.size.name)
        .limit(1)
        .get();

    return querySnapshot.docs.isNotEmpty
        ? Product.fromQueryDocumentSnapshot(querySnapshot.docs.first)
        : null;
  }

  Future<void> remove(Product product) async {
    final String? userId = ref.read(userNotifier)!.id;
    if (product.quantity > 1) {
      product.removeQuantity();
      await FirebaseFirestore.instance
          .collection('cart')
          .doc(userId)
          .collection("product")
          .doc(product.id)
          .update(product.toSnapshot());
    } else {
      await FirebaseFirestore.instance
          .collection('cart')
          .doc(userId)
          .collection("product")
          .doc(product.id)
          .delete();
    }
  }
}
