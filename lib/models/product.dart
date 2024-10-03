import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cours_flutter/models/pizza.dart';
import 'package:cours_flutter/models/enums/size.dart';

class Product {
  String? id;
  String name;
  num totalPrice;
  Size size;
  int quantity;

  Product({
    this.id,
    required this.name,
    required this.totalPrice,
    required this.size,
    required this.quantity,
  });

  Map<String, dynamic> toSnapshot() {
    return {
      'id': id ?? "",
      'name': name,
      'totalPrice': totalPrice,
      'size': size.name,
      'quantity': quantity,
    };
  }

  factory Product.fromSnapshot(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? "",
      name: json['name'],
      totalPrice: json['totalPrice'],
      size: Size.values.firstWhere((e) => e.name == json['size']),
      quantity: json['quantity'],
    );
  }
  
  static List<Product> fromListSnapshot(List<dynamic> json) {
    return json.map((e) => Product.fromSnapshot(e)).toList();  
  }

  factory Product.fromPizza({required Pizza pizza}) {
    return Product(
      name: pizza.name,
      totalPrice: pizza.price,
      size: pizza.size,
      quantity: 1,
    );
  }

  factory Product.fromQueryDocumentSnapshot(QueryDocumentSnapshot doc) {
    return Product(
      id: doc.id,
      name: doc['name'],
      totalPrice: doc['totalPrice'],
      size: Size.values.firstWhere((e) => e.name == doc['size']),
      quantity: doc['quantity'],
    );
  }

  void addQuantity(num unitPrice) {
    quantity++;
    totalPrice = unitPrice * quantity;
  }

  void removeQuantity() {
    num unitPrice = totalPrice / quantity;
    quantity--;
    totalPrice = unitPrice * quantity;
  }
}
