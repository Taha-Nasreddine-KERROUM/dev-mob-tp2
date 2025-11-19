class Meal {
  final String name;
  final String imgPath;
  final List<String> listOfIngredient;
  final String? identifier;

  Meal({
    required this.name,
    required this.imgPath,
    required this.listOfIngredient,
    this.identifier,
  });
}