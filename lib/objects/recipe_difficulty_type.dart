enum RecipeDifficultyType { EVERYBODY, BEGINNERS, INTERMEDIATES, PRO }

extension RecipeDifficultyTypeExtension on RecipeDifficultyType {
  String get hebrewLabel {
    switch (this) {
      case RecipeDifficultyType.EVERYBODY:
        return 'לכולם';
      case RecipeDifficultyType.BEGINNERS:
        return 'קל';
      case RecipeDifficultyType.INTERMEDIATES:
        return 'בינוני';
      case RecipeDifficultyType.PRO:
        return 'מומחים';
    }
  }
}
