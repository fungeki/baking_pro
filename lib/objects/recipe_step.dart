import 'dart:io';

class RecipeStep {
  String instructions;
  File? image;

  RecipeStep({required this.instructions, this.image});
  RecipeStep.empty() : this.instructions = '';
}
