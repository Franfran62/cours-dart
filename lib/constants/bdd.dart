import 'package:cours_flutter/models/ingredient.dart';
import 'package:cours_flutter/models/pizza.dart';
import 'package:cours_flutter/models/size.dart';

  List<Ingredient> ingredients = [
    Ingredient(name: "cheese", vegan: true),
    Ingredient(name: "onion", vegan: true),
    Ingredient(name: "tomato pure", vegan: true),
    Ingredient(name: "hungarian", vegan: true),
    Ingredient(name: "pepper", vegan: true),
    Ingredient(name: "paneer", vegan: true),
    Ingredient(name: "capsicum", vegan: true),
    Ingredient(name: "chicken", vegan: false)
  ];

  List<Pizza> pizzas = [
    Pizza(
        name: "Margarita",
        ingredients:  [
          ingredients.firstWhere((ingredient) => ingredient.name == "cheese"),
          ingredients.firstWhere((ingredient) => ingredient.name == "onion"),
          ingredients.firstWhere((ingredient) => ingredient.name == "tomato pure")
        ],
        price: 12,
        size: Size.Medium,
        image: "assets/pizza-margarita.png"
    ),
    Pizza(
        name: "Classic Pepporoni",
        ingredients: [
          ingredients.firstWhere((ingredient) => ingredient.name == "onion"),
          ingredients.firstWhere((ingredient) => ingredient.name == "pepper"),
          ingredients.firstWhere((ingredient) => ingredient.name == "capsicum"),
        ],
        price: 12,
        size: Size.Medium,
        image: "assets/pizza-margarita.png"
    ),
    Pizza(
        name: "Chicken Supreme",
        ingredients: [
            ingredients.firstWhere((ingredient) => ingredient.name == "cheese"),
            ingredients.firstWhere((ingredient) => ingredient.name == "onion"),
            ingredients.firstWhere((ingredient) => ingredient.name == "chicken"),
            ingredients.firstWhere((ingredient) => ingredient.name == "tomato pure")
          ],
        price: 12,
        size: Size.Medium,
        image: "assets/pizza-margarita.png"
    ),
    Pizza(
        name: "Vegetarian",
        ingredients: [
            ingredients.firstWhere((ingredient) => ingredient.name == "cheese"),
            ingredients.firstWhere((ingredient) => ingredient.name == "onion"),
            ingredients.firstWhere((ingredient) => ingredient.name == "tomato pure")
          ],
        price: 12,
        size: Size.Medium,
        image: "assets/pizza-margarita.png"
    )
  ];
