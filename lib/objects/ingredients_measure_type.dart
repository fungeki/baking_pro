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
        return '  ';
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
}
