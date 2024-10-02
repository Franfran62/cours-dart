import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cours_flutter/models/pizza.dart';
import 'package:cours_flutter/models/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cartStreamProvider = StreamNotifierProvider<CartStreamNotifier, List<Product>>(CartStreamNotifier.new);

class CartStreamNotifier extends StreamNotifier<List<Product>> {
  @override
  Stream<List<Product>> build() {
    return FirebaseFirestore.instance
        .collection('cart')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => Product.fromQueryDocumentSnapshot(doc)).toList());
  }

  Future<void> add(Pizza pizza) async {
    Product product = Product.fromPizza(pizza: pizza);
    Product? productAlreadyInCart = await alreadyInCart(product: product);
    if (productAlreadyInCart != null) {
      productAlreadyInCart.addQuantity(pizza.price);
      await FirebaseFirestore.instance
          .collection('cart')
          .doc(productAlreadyInCart.id)
          .update(productAlreadyInCart.toJson());
      return;
    } else {
      await FirebaseFirestore.instance.collection('cart').add(product.toJson());
    }
  }

  Future<Product?> alreadyInCart({required Product product}) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('cart')
        .where('name', isEqualTo: product.name)
        .where('size', isEqualTo: product.size.name)
        .limit(1)
        .get();

    return querySnapshot.docs.isNotEmpty ? Product.fromQueryDocumentSnapshot(querySnapshot.docs.first) : null;
  }

  Future<void> remove(Product product) async {
    if (product.quantity > 1) {
      product.removeQuantity();
      await FirebaseFirestore.instance.collection('cart').doc(product.id).update(product.toJson());
    } else {
      await FirebaseFirestore.instance.collection('cart').doc(product.id).delete();
    }
  }
}
