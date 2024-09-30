import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cours_flutter/models/ingredient.dart';
import 'package:cours_flutter/models/size.dart';

class Pizza {

  String name;
  List<Ingredient>? ingredients;
  num price; 
  Size size;
  String image;

  Pizza({required this.name, this.ingredients, required this.price, required this.size, required this.image});

  factory Pizza.fromQueryDocumentSnapshot(QueryDocumentSnapshot snapshot) {
   
    return Pizza(
      name: snapshot['name'], 
    //  ingredients: Ingredient.fromList(snapshot['ingredient']), 
      price: snapshot['price'], 
      size: Size.values.firstWhere((e) => e.name == snapshot['size']), 
      image: snapshot['image']);
  }

  Map<String, dynamic> toSnapshot() {
    return {
      'name': name,
      'ingredients': ingredients ?? "",
      'price': price,
      'size': size.name,
      'image': image
    };
  }

  String displayIngredients() {
    return ingredients != null ? ingredients!.join(", ") : "";
  }
}
