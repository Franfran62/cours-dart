import 'package:cours_flutter/base/base_scaffold.dart';
import 'package:cours_flutter/models/ingredient.dart';
import 'package:cours_flutter/models/pizza.dart';
import 'package:cours_flutter/models/size.dart';
import 'package:cours_flutter/widgets/pizza_card.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    Ingredient cheese = Ingredient(
        name: "cheese",
        vegan: true);
    Ingredient onion = Ingredient(
        name: "onion",
        vegan: true);
    Ingredient tomato = Ingredient(
        name: "tomato pure",
        vegan: true);
    Ingredient hungarian = Ingredient(
        name: "hungarian",
        vegan: true);
    Ingredient pepper = Ingredient(
        name: "pepper",
        vegan: true);
    Ingredient paneer = Ingredient(
        name: "paneer",
        vegan: true);
    Ingredient capsicum = Ingredient(
        name: "capsicum",
        vegan: true);  
    Ingredient chicken = Ingredient(
        name: "chicken",
        vegan: false); 

    List<Pizza> pizzas = [
      Pizza(
        name: "Margarita",
        ingredients: [cheese, onion, tomato],
        price: 12,
        size: Size.Medium,
        image: "assets/pizza-margarita.png"
      ),
      Pizza(
        name: "Classic Pepporoni",
        ingredients: [
          cheese, hungarian, pepper, paneer, capsicum, onion
        ],
        price: 12,
        size: Size.Medium,
        image: "assets/pizza-margarita.png"
      ),
      Pizza(
        name: "Chicken Supreme",
        ingredients: [
          cheese, onion, tomato, chicken
        ],
        price: 12,
        size: Size.Medium,
        image: "assets/pizza-margarita.png"
      ),
      Pizza(
        name: "Vegetarian",
        ingredients: [
          cheese, onion, tomato
        ],
        price: 12,
        size: Size.Medium,
        image: "assets/pizza-margarita.png"
      )
    ];

    return Basescaffold(
        title: "ForEach Pizza",
        body:ListView(
          children: pizzas
              .map((pizza) => PizzaCard(pizza: pizza))
              .toList(),
        )
    );
  }
}
