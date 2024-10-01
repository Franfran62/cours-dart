import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cours_flutter/models/pizza.dart';
import 'package:cours_flutter/models/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final cartStreamProvider = StreamProvider.autoDispose<List<Pizza>>((ref) {
  return FirebaseFirestore.instance
      .collection('pizzas')
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => Pizza.fromQueryDocumentSnapshot(doc)).toList());
});

final cartProvider = StateNotifierProvider<CartNotifier, FirebaseFirestore>(
    (ref) => CartNotifier());


class CartNotifier extends StateNotifier<FirebaseFirestore> {
  CartNotifier() : super(FirebaseFirestore.instance);

  Future<void> add(Pizza pizza) async {
    Product product = Product.fromPizza(pizza: pizza);
    Product? productAlreadyInCart = await alreadyInCart(product: product);
    if (productAlreadyInCart != null) {
      productAlreadyInCart.addQuantity(pizza.price);
      await state
          .collection('cart')
          .doc(productAlreadyInCart.id)
          .update(productAlreadyInCart.toJson());
      return;
    } else {
      await state.collection('cart').add(product.toJson());
    }
  }

  Future<Product?> alreadyInCart({required Product product}) async {
    QuerySnapshot querySnapshot = await state
        .collection('cart')
        .where('name', isEqualTo: product.name)
        .where('size', isEqualTo: product.size.name)
        .limit(1)
        .get();


    return querySnapshot.docs.isNotEmpty
        ? Product.fromQueryDocumentSnapshot(querySnapshot.docs.first)
        : null;
  }

  Future<void> remove(Product product) async {
    if (product.quantity > 1) {
      product.removeQuantity();
      await state.collection('cart').doc(product.id).update(product.toJson());
    } else {
      await state.collection('cart').doc(product.id).delete();
    }
  }
}
