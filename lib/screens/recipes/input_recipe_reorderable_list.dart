import 'package:baking_pro/Utils/constants.dart';
import 'package:baking_pro/objects/ingredient.dart';
import 'package:baking_pro/objects/recipe_step.dart';
import 'package:baking_pro/widgets/bakezone_app_bar.dart';
import 'package:flutter/material.dart';

class InputRecipeReorderableList extends StatefulWidget {
  InputRecipeReorderableList(
      {Key? key, this.ingredients, this.steps, required this.isIngredient})
      : super(key: key);

  final bool isIngredient;
  List<RecipeStep>? steps;
  List<Ingredient>? ingredients;
  @override
  _InputRecipeReorderableListState createState() =>
      _InputRecipeReorderableListState();
}

class _InputRecipeReorderableListState
    extends State<InputRecipeReorderableList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: BakeZoneAppbar(
        isProfileImageLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ReorderableListView(
          padding: EdgeInsets.all(8.0),
          onReorder: (int oldIndex, int newIndex) {
            setState(() {
              if (oldIndex < newIndex) {
                newIndex -= 1;
              }
              if (widget.isIngredient) {
                Ingredient item = widget.ingredients![oldIndex];
                widget.ingredients!.removeAt(oldIndex);
                widget.ingredients!.insert(newIndex, item);
              } else {
                RecipeStep item = widget.steps![oldIndex];
                widget.steps!.removeAt(oldIndex);
                widget.steps!.insert(newIndex, item);
              }
            });
          },
          children: widget.isIngredient
              ? buildTilesForIngredients()
              : buildTilesForRecipeSteps(),
        ),
      ),
    );
  }

  List<Widget> buildTilesForIngredients() {
    int index = -1;
    return widget.ingredients!.map((e) {
      index++;
      return buildListTile(e.title, index);
    }).toList();
  }

  List<Widget> buildTilesForRecipeSteps() {
    List<ListTile> tiles = [];
    return tiles;
  }

  Widget buildListTile(String title, int index) {
    final validateTitle = title.length > 1 ? title : '';
    return ListTile(
      contentPadding: EdgeInsets.all(8.0),
      key: Key('$index'),
      title: Text(
        validateTitle,
        style: kBodyTextStyle,
      ),
      tileColor: index.isOdd ? kBakeZoneOrange : kBakeZoneGreen,
    );
  }
}
