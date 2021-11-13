import 'package:baking_pro/objects/ingredients_measure_type.dart';

class Ingredient {
  String title;
  String? amount;
  String? grams;
  IngredientsMeasureType ingredientsMeasureType;

  Ingredient(
      {required this.title, this.amount, required this.ingredientsMeasureType});
  Ingredient.empty()
      : this.title = "",
        ingredientsMeasureType = IngredientsMeasureType.EMPTY;

  @override
  String toString() {
    return 'Ingredient{title: $title, amount: $amount, ingredientsMeasureType: $ingredientsMeasureType}';
  }
}
