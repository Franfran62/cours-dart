class Ingredient {
  String name;
  bool vegan;

  Ingredient({required this.name, required this.vegan});

  static List<Ingredient> fromList(List<dynamic> snapshots) {
    print(snapshots.first.toString());
    return snapshots.map((ingredient) {
      return Ingredient(name: ingredient.name, vegan: ingredient.vegan);
    }).toList();
  }

  @override
  String toString() {
    return name;
  }
}
