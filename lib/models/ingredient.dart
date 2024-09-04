class Ingredient {

  String name; 
  bool vegan; 

  Ingredient({required this.name, required this.vegan});

@override
  String toString() {
    return this.name;
  }
}