import 'package:cours_flutter/models/ingredient.dart';

class Pizza {

  String name;
  List<Ingredient> ingredients;
  bool vegan = true;
  num price; 

  Pizza({required this.name, required this.ingredients, required this.price}) {
    this.setVeganInfos();
  }

  String isVegan() {
    return "La pizza $name est veggie ? => $vegan";
  }

  String displayIngredients() {
    String response = "";
    for (var i = 0; i < ingredients.length; i++) {
        response += ingredients[i].name;
        if (i != ingredients.length) {
          response += ", ";
        }
    }
    return response;
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
