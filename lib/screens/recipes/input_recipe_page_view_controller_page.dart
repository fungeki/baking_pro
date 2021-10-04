import 'package:baking_pro/objects/recipe_post.dart';
import 'package:baking_pro/screens/recipes/input_recipe_add_ingredients_page.dart';
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
  late PageController _inputPagesForRecipeController;
  RecipePost finaRecipe = RecipePost();
  @override
  void initState() {
    inputPages = [
      InputRecipeInitDataPage(
        nextPressed: () {
          _inputPagesForRecipeController.animateToPage(1,
              duration: Duration(milliseconds: 400), curve: Curves.easeIn);
        },
      ),
      InputRecipeAddIngredients(),
    ];
    _inputPagesForRecipeController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _inputPagesForRecipeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BakeZoneAppbar(
        isProfileImageLeading: false,
        isProfileImageTrailing: true,
      ),
      body: SafeArea(
        child: PageView(
          controller: _inputPagesForRecipeController,
          children: inputPages,
        ),
      ),
    );
  }
}
