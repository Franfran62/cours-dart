
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cours_flutter/models/pizza.dart';
import 'package:cours_flutter/models/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cartProvider = StateNotifierProvider<CartNotifier, FirebaseFirestore>((ref) => CartNotifier());

class CartNotifier extends StateNotifier<FirebaseFirestore> {
  CartNotifier() : super(FirebaseFirestore.instance); 


  Future<void> add(Pizza pizza) async {
    Product product = Product.fromPizza(pizza: pizza);
    Product? productAlreadyInCart = await alreadyInCart(product: product);
    if (productAlreadyInCart != null) {
      productAlreadyInCart.addQuantity(pizza.price);
      await state.collection('cart').doc(productAlreadyInCart.id).update(productAlreadyInCart.toJson());
      return;   
    } else {
      await state.collection('cart').add(product.toJson());
    }
  }

  Future<Product?> alreadyInCart({required Product product}) async {
    QuerySnapshot querySnapshot = await state.collection('cart')
      .where('name', isEqualTo: product.name)
      .where('size', isEqualTo: product.size.name)
      .limit(1)
      .get();

    return querySnapshot.docs.isNotEmpty 
      ?  Product.fromQueryDocumentSnapshot(querySnapshot.docs.first)
      :  null;
  }

  Future<void> remove(Product product) async {
    Product? productAlreadyInCart = await alreadyInCart(product: product);
    if (productAlreadyInCart != null) {
      if (productAlreadyInCart.quantity > 1) {
        productAlreadyInCart.removeQuantity();
        await state.collection('cart').doc(productAlreadyInCart.id).update(productAlreadyInCart.toJson());
      } else {
        await state.collection('cart').doc(productAlreadyInCart.id).delete();
      }
    }
  }
}