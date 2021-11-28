import 'package:baking_pro/objects/recipe_step.dart';

class RecipeStepsHeadlines {
  List<RecipeStep> steps;
  String headline;

  RecipeStepsHeadlines(this.headline, this.steps);
  RecipeStepsHeadlines.name(this.steps, this.headline);
}
