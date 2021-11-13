import 'package:baking_pro/objects/ingredient.dart';
import 'package:baking_pro/objects/recipe_ingredient_headlines.dart';
import 'package:baking_pro/objects/recipe_steps_headlines.dart';
import 'package:flutter/material.dart';

class RecipePost {
  String? title;
  String? description;
  int? workTime;
  int? totalTime;
  int? difficulty;
  List<RecipeIngredientHeadline> ingredientsHeadlines;
  List<RecipeStepsHeadlines> stepsHeadlines;

  RecipePost({
    this.title,
    this.description,
    this.workTime,
    this.totalTime,
    this.difficulty,
    required this.ingredientsHeadlines,
    required this.stepsHeadlines,
  });

  RecipePost.empty()
      : this.ingredientsHeadlines = [],
        this.stepsHeadlines = [];
  fillOutInitInfo(RecipePost post) {
    this.title = post.title;
    this.description = post.title;
    this.workTime = post.workTime;
    this.totalTime = post.totalTime;
    this.difficulty = post.difficulty;
  }
}
