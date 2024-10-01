import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cours_flutter/models/enums/base.dart';
import 'package:cours_flutter/models/ingredient.dart';
import 'package:cours_flutter/models/size.dart';

class Pizza {

  String name;
  List<Ingredient>? ingredients;
  num price; 
  Size size;
  String image;
  Base base;

  Pizza({
    this.ingredients, 
    required this.name, 
    required this.price, 
    required this.size, 
    required this.image,
    required this.base
    });

  factory Pizza.fromQueryDocumentSnapshot(QueryDocumentSnapshot snapshot) { 
    return Pizza(
      name: snapshot['name'], 
      ingredients: Ingredient.fromList(snapshot['ingredient']), 
      price: snapshot['price'], 
      size: Size.values.firstWhere((e) => e.name == snapshot['size']), 
      image: snapshot['image'],
      base: Base.values.firstWhere((e) => e.name == snapshot['base'])
    );
  }

  Map<String, dynamic> toSnapshot() {
    return {
      'name': name,
      'ingredients': ingredients ?? "",
      'price': price,
      'size': size.name,
      'image': image,
      'base': base.name
    };
  }

  String displayIngredients() {
    return ingredients != null ? ingredients!.join(", ") : "";
  }
}
