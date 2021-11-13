enum IngredientsMeasureType {
  EMPTY,
  TEASPOON,
  SPOON,
  CUPS,
  GRAMS,
  KILOS,
  ML,
  LITRE,
}

extension IngredientsMeasureTypeExtension on IngredientsMeasureType {
  String get hebrewLabel {
    switch (this) {
      case IngredientsMeasureType.EMPTY:
        return 'כמות';
      case IngredientsMeasureType.TEASPOON:
        return 'כפיות';
      case IngredientsMeasureType.GRAMS:
        return 'גרם';
      case IngredientsMeasureType.KILOS:
        return 'קילו';
      case IngredientsMeasureType.CUPS:
        return 'כוסות';
      case IngredientsMeasureType.ML:
        return 'מ״ל';
      case IngredientsMeasureType.LITRE:
        return 'ליטר';
      case IngredientsMeasureType.SPOON:
        return 'כפות';
    }
  }

  bool get canHaveGramValue {
    switch (this) {
      case IngredientsMeasureType.EMPTY:
        return false;
      case IngredientsMeasureType.TEASPOON:
        return true;
      case IngredientsMeasureType.SPOON:
        return true;
      case IngredientsMeasureType.CUPS:
        return true;
      case IngredientsMeasureType.GRAMS:
        return false;
      case IngredientsMeasureType.KILOS:
        return false;
      case IngredientsMeasureType.ML:
        return false;
      case IngredientsMeasureType.LITRE:
        return false;
    }
  }
}
