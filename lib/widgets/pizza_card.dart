import 'package:cours_flutter/models/pizza.dart';
import 'package:flutter/material.dart';

class PizzaCard extends StatelessWidget {
  final Pizza pizza;
  const PizzaCard({super.key, required this.pizza});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.80,
        height: MediaQuery.of(context).size.height / 6,
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Row(
            children: [
              SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image(
                        image: AssetImage(pizza.image), fit: BoxFit.fitHeight),
                  )),
              Expanded(
                child : Padding(
                padding: EdgeInsets.only(left: 20, top: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pizza.name,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w600),
                      maxLines: 1,
                    ),
                    Text(
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        pizza.displayIngredients(),
                        style: const TextStyle(fontStyle: FontStyle.italic),
                      ),
                    Text(
                      "${pizza.price}€",
                      style: const TextStyle(fontSize: 18),
                    )
                  ],
                ),
              ),
              ),
              Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    onPressed: () => {print("coucou")},
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll<Color>(Colors.orangeAccent),

                    ),
                    child: Row(
                      children: [
                        Text("Add "),
                        Icon(Icons.add)
                      ],
                  )
                ),
              ),
            ],
          ),
        ),
    );
  }
}

// child: 