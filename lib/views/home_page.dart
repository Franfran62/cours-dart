import 'package:cours_flutter/models/ingredient.dart';
import 'package:cours_flutter/models/pizza.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    Ingredient ingredient = Ingredient(
        name: "fromage",
        description: "Le fromage français, c'est bon",
        vegan: true);
    Ingredient ingredient2 = Ingredient(
        name: "tomate",
        description: "La tomate espagnole, c'est bon",
        vegan: true);
    Ingredient ingredient3 = Ingredient(
        name: "viande",
        description: "La viande, on aime ou on n'aime pas",
        vegan: false);

    List<Pizza> pizzas = [
      Pizza(
        name: "La viandard",
        ingredients: [ingredient, ingredient2, ingredient3],
        price: 11,
      ),
      Pizza(
        name: "La Veggie",
        ingredients: [ingredient, ingredient2],
        price: 9,
      ),
      Pizza(
        name: "La Pas Ouf",
        ingredients: [
          ingredient,
        ],
        price: 178,
      )
    ];

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Exercice Liste des pizzas"),
        ),
        body: ListView(
          children: pizzas
              .map((pizza) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: Column(children: [
                    Row(
                      children: [
                        Text(pizza.name),
                        if (pizza.vegan)
                          const Icon(
                            Icons.grass,
                            color: Colors.green,
                            size: 30.0,
                          )
                      ],
                    ),
                    Row(
                      children: [Text(pizza.displayIngredients())],
                    )
                  ])))
              .toList(),
        ));
  }
}
