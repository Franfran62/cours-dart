import 'package:cours_flutter/models/ingredient.dart';
import 'package:cours_flutter/models/size.dart';

class Pizza {

  String name;
  List<Ingredient> ingredients;
  bool vegan = true;
  num price; 
  Size size;
  String image;

  Pizza({required this.name, required this.ingredients, required this.price, required this.size, required this.image}) {
    this.setVeganInfos();
  }

  String displayIngredients() {
    return ingredients.join(", ");
  }

  void setVeganInfos() {
    for (var ingredient in ingredients) {
      if (!ingredient.vegan) {
        vegan = false;
        return;
      }
    }
  }
}
