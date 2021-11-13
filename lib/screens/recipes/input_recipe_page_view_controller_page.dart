import 'package:baking_pro/objects/ingredient.dart';
import 'package:baking_pro/objects/recipe_ingredient_headlines.dart';
import 'package:baking_pro/objects/recipe_post.dart';
import 'package:baking_pro/screens/recipes/input_recipe_add_ingredients_page.dart';
import 'package:baking_pro/screens/recipes/input_recipe_add_steps_page.dart';
import 'package:baking_pro/screens/recipes/input_recipe_init_data_page.dart';
import 'package:baking_pro/widgets/bakezone_app_bar.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class InputRecipePagaeViewControllerPage extends StatefulWidget {
  const InputRecipePagaeViewControllerPage({Key? key}) : super(key: key);

  @override
  _InputRecipePagaeViewControllerPageState createState() =>
      _InputRecipePagaeViewControllerPageState();
}

class _InputRecipePagaeViewControllerPageState
    extends State<InputRecipePagaeViewControllerPage> {
  late List<Widget> inputPages;
  late List<Widget> originPagesList;
  late PageController _inputPagesForRecipeController;
  RecipePost finalRecipe = RecipePost.empty();
  Map<String, int> recipeIngredientsIndexes = Map<String, int>();
  Map<String, int> recipeStepsIndexes = Map<String, int>();

  bool hasEmptyIngredientInputPage = true;
  int currentIndex = 0;

  void onIngredientDeletePressed() {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('מחיקת עמוד'),
        content: const Text('מחיקת העמוד תסיר את כל המצרכים תחת הכותרת'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('ביטול'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              deleteIngredientPage();
            },
            child: const Text('מחיקה'),
          ),
        ],
      ),
    );
  }

  void deleteIngredientPage() {
    final currentPage =
        inputPages[currentIndex - 1] as InputRecipeAddIngredients;
    if (currentPage.key != null) {
      final pageKey = currentPage.key! as GlobalKey;
      pageKey.currentState!.setState(() {
        currentPage.displayDelete = true;
      });
    }
    String keyToDelete = '';
    recipeIngredientsIndexes.forEach((key, value) {
      if (value == currentIndex) keyToDelete = key;
    });
    if (keyToDelete.length > 1) {
      recipeIngredientsIndexes.remove(keyToDelete);
    }

    final pageToDelete = inputPages[currentIndex];
    setState(() {
      inputPages.remove(pageToDelete);
      animateToPage(currentIndex - 1);
    });
  }

  @override
  void initState() {
    inputPages = [
      InputRecipeInitDataPage(
        nextPressed: (RecipePost recipe) {
          animateToPage(1);
          finalRecipe.fillOutInitInfo(recipe);
        },
      ),
      InputRecipeAddIngredients(
        backPressed: () => animateToPage(0),
        nextPressed: onInputIngredientNextPressed,
      ),
      InputRecipeAddStepsPage(
        backPressed: () => animateToPage(currentIndex - 1),
      ),
    ];
    originPagesList = inputPages;
    _inputPagesForRecipeController = PageController(initialPage: 0);
    super.initState();
  }

  String createNewHeadline(String headline, int index) {
    String strIndex = index.toString();
    String newHeadline = headline + " $strIndex";
    if (recipeIngredientsIndexes.containsKey(newHeadline)) {
      return createNewHeadline(headline, index + 1);
    } else
      return newHeadline;
  }

  onInputIngredientNextPressed(List<Ingredient> ingredients, String headline) {
    List<Ingredient> trimmed = List.from(ingredients);
    trimmed.removeLast();
    final headlineIndex = recipeIngredientsIndexes[headline];
    bool isLastPage = recipeIngredientsIndexes.length + 1 == currentIndex;
    String newHeadline = headline;
    if (recipeIngredientsIndexes.containsKey(headline)) {
      if (ingredients.length == 0) {
        ingredients.add(Ingredient.empty());
      }
      if (currentIndex != headlineIndex!) {
        newHeadline = createNewHeadline(headline, 2);
      }
      finalRecipe.ingredientsHeadlines[headlineIndex - 1].ingredients =
          ingredients;

      inputPages[currentIndex + 1] is InputRecipeAddIngredients
          ? isLastPage = false
          : isLastPage = true;
    } else {
      finalRecipe.ingredientsHeadlines
          .add(RecipeIngredientHeadline(headline, trimmed));
    }
    print(isLastPage);
    isLastPage
        ? buildDialogToAddIngredientPage(newHeadline)
        : animateToPage(currentIndex + 1);
  }

  void moveToNextIngredientPage(String headline) {
    if (recipeIngredientsIndexes.containsKey(headline)) {
      animateToPage(recipeIngredientsIndexes[headline]! + 1);
    } else {
      animateToPage(3);
    }
  }

  void buildDialogToAddIngredientPage(String headline) {
    recipeIngredientsIndexes[headline] = currentIndex;
    showDialog<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('הוספת עמוד מצרכים'),
        content: const Text('האם להוסיף עמוד מצרכים נוסף?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              hasEmptyIngredientInputPage = false;
              animateToPage(currentIndex + 1);
            },
            child: const Text('לא'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              hasEmptyIngredientInputPage = true;
              final currentPage =
                  inputPages[currentIndex] as InputRecipeAddIngredients;

              if (currentPage.key != null) {
                final pageKey = currentPage.key! as GlobalKey;
                pageKey.currentState!.setState(() {
                  currentPage.displayDelete = false;
                });
              }
              buildNewRecipeInputPage(headline);
            },
            child: const Text('הוספת עמוד'),
          ),
        ],
      ),
    );
  }

  void buildNewRecipeInputPage(String headline) {
    final index = currentIndex + 1;
    setState(() {
      inputPages.insert(
          index,
          InputRecipeAddIngredients(
              key: GlobalKey(),
              onDelete: onIngredientDeletePressed,
              backPressed: () => animateToPage(currentIndex - 1),
              nextPressed: onInputIngredientNextPressed));
      final page = inputPages[index] as InputRecipeAddIngredients;
      page.displayDelete = true;
      animateToPage(index);
    });
  }

  void buildTitlesIndexMap(List<String> titles) {
    int currentPlace = 2;
    titles.forEach((element) {
      recipeIngredientsIndexes[element] = currentPlace;
      currentPlace++;
    });
  }

  void animateToPage(int page) {
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() {
      _inputPagesForRecipeController.animateToPage(page,
          duration: Duration(milliseconds: 400), curve: Curves.easeIn);
    });
  }

  @override
  void dispose() {
    _inputPagesForRecipeController.dispose();
    super.dispose();
  }

  Future<bool> _onWillPop(BuildContext context) async {
    FocusScope.of(context).unfocus();
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('יציאה מיצירת מתכון?'),
            content: Text('יציאה ממתכון תמחק את השינויים'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('להשאר'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('לצאת'),
              ),
            ],
          ),
        )) ??
        false;
  }

  void onPageChanged(int page) {
    currentIndex = page;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
        appBar: BakeZoneAppbar(
          isProfileImageLeading: false,
          isProfileImageTrailing: true,
        ),
        body: SafeArea(
          child: PageView.builder(
            onPageChanged: (page) {
              onPageChanged(page);
            },
            itemCount: inputPages.length,
            controller: _inputPagesForRecipeController,
            itemBuilder: (context, index) {
              return inputPages[index];
            },
          ),
        ),
      ),
    );
  }
}
// List<String>? headlinesForIngredientsList;
// void createIngredientHeadlines(List<String> titles) {
//   if (headlinesForIngredientsList == null) {
//     finalRecipe.ingredientsHeadlines = null;
//     return;
//   }
//   finalRecipe.ingredientsHeadlines = [];
//   headlinesForIngredientsList!.forEach((element) {
//     finalRecipe.ingredientsHeadlines!
//         .add(RecipeIngredientHeadline(element, []));
//   });
// }
// void onIngredientHeadlineNextPressed(List<String> titles) {
//   if (titles.length == 0) {
//     finalRecipe.ingredientsHeadlines = [
//       RecipeIngredientHeadline('המתכון', [])
//     ];
//     animateToPage(2);
//     return;
//   }
//   titles.removeLast();
//   if (inputPages.length == originPagesList.length) {
//     headlinesForIngredientsList = titles;
//     inputPages.removeAt(2);
//     buildTitlesIndexMap(titles);
//     createIngredientHeadlines(titles);
//     buildIngredientsInputPages(titles);
//     setState(() {
//       inputPages.insertAll(2, recipeIngredientsInputPages);
//       animateToPage(2);
//     });
//   } else {
//     List<String> newTitles = [];
//     if (headlinesForIngredientsList != null) {
//       newTitles = titles
//           .where((element) => !headlinesForIngredientsList!.contains(element))
//           .toList();
//     } else {
//       newTitles = titles;
//     }
//     createIngredientHeadlines(newTitles);
//     List<Widget> newIngredientPages = buildIngredientsInputPages(titles);
//     final recipeInputPagesAmount = headlinesForIngredientsList != null
//         ? 1 + headlinesForIngredientsList!.length
//         : 2;
//     inputPages.insertAll(recipeInputPagesAmount, newIngredientPages);
//   }
// }
// List<Widget> buildIngredientsInputPages(List<String> titles) {
//   List<Widget> ingredientPages = [];
//   if (finalRecipe.ingredientsHeadlines == null)
//     finalRecipe.ingredientsHeadlines = [];
//   final totalPages = finalRecipe.ingredientsHeadlines!.length;
//   if (totalPages < 2) {
//     ingredientPages.add(
//       InputRecipeAddIngredients(
//           backPressed: () => animateToPage(1),
//           nextPressed: (ingredients) {
//             finalRecipe.ingredientsHeadlines = [
//               RecipeIngredientHeadline('', ingredients)
//             ];
//             animateToPage(2);
//           },
//           headline: 'המתכון'),
//     );
//   } else {
//     titles.forEach((element) {
//       ingredientPages.add(InputRecipeAddIngredients(
//           backPressed: () =>
//               animateToPage(recipeIngredientsIndexes[element]! - 1),
//           nextPressed: (ingredients) {
//             List<Ingredient> trimmedIngredients = List.from(ingredients);
//             trimmedIngredients.removeLast();
//             finalRecipe
//                 .ingredientsHeadlines![recipeIngredientsIndexes[element]! - 2]
//                 .ingredients = trimmedIngredients;
//             animateToPage(recipeIngredientsIndexes[element]! + 1);
//           },
//           headline: element));
//     });
//   }
//   recipeIngredientsInputPages = ingredientPages;
//   return ingredientPages;
// }
//
// void _deleteIngredientHeadline(int index) {
//   if (recipeIngredientsInputPages.length <= 1) return;
//   finalRecipe.ingredientsHeadlines!.removeAt(index);
//   recipeIngredientsInputPages.removeAt(index);
//   setState(() {
//     inputPages.removeAt(index + 2);
//   });
// }
