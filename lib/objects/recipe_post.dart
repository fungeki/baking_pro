import 'package:baking_pro/objects/ingredient.dart';

class RecipePost {
  String? title;
  String? description;
  int? workTime;
  int? totalTime;
  int? difficulty;
  List<Ingredient>? ingredients;

  RecipePost(
      {this.title,
      this.description,
      this.workTime,
      this.totalTime,
      this.difficulty,
      this.ingredients});
}
