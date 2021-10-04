import 'package:baking_pro/Utils/constants.dart';
import 'package:baking_pro/objects/ingredient.dart';
import 'package:baking_pro/objects/ingredients_measure_type.dart';
import 'package:baking_pro/widgets/BakeZoneTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class InputRecipeAddIngredients extends StatefulWidget {
  const InputRecipeAddIngredients({Key? key}) : super(key: key);

  @override
  _InputRecipeAddIngredientsState createState() =>
      _InputRecipeAddIngredientsState();
}

class _InputRecipeAddIngredientsState extends State<InputRecipeAddIngredients> {
  List<Ingredient> ingredientsList = [Ingredient.empty()];
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  final _listScrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return AnimatedList(
        key: listKey,
        controller: _listScrollController,
        itemBuilder: (BuildContext context, int index, animation) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset(0, 0),
            ).animate(animation),
            child: IngredientInputCard(
              ingredient: ingredientsList[index],
              onIngredientChange: _onIngredientChange,
              deleteIngredient: _deleteItem,
              index: index,
            ),
          );
        },
        initialItemCount: 1);
  }

  _deleteItem(BuildContext context, int index) {
    FocusManager.instance.primaryFocus?.unfocus();
    if (index == ingredientsList.length - 1) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("רכיב אחרון נשאר ריק, אין צורך במחיקה"),
      ));
      return;
    }
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text('מחיקת רכיב'),
              content: Text('האם למחוק את הרכיב מהרשימה?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text(
                    'ביטול',
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    listKey.currentState?.removeItem(
                        index,
                        (context, animation) => SizeTransition(
                              sizeFactor: animation,
                              axis: Axis.vertical,
                              child: IngredientInputCard(
                                ingredient: ingredientsList[index],
                                onIngredientChange: _onIngredientChange,
                                deleteIngredient: _deleteItem,
                                index: index,
                              ),
                            ),
                        duration: Duration(milliseconds: 300));
                    ingredientsList.removeAt(index);
                  },
                  child: const Text(
                    'מחיקה',
                    style: TextStyle(color: kBakeZoneOrange),
                  ),
                ),
              ],
            ));
  }

  _onIngredientChange(Ingredient ingredient, int index) {
    print(ingredient.toString());
    if (index == ingredientsList.length - 1) {
      ingredientsList.add(Ingredient.empty());
      listKey.currentState
          ?.insertItem(index + 1, duration: Duration(milliseconds: 300));
      Future.delayed(const Duration(milliseconds: 350), () {
        setState(() {
          _listScrollController.animateTo(
            _listScrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 400),
            curve: Curves.fastOutSlowIn,
          );
        });
      });
    }
    ingredientsList[index] = ingredient;
  }
}

class IngredientInputCard extends StatefulWidget {
  IngredientInputCard({
    Key? key,
    required this.ingredient,
    required this.onIngredientChange,
    required this.index,
    required this.deleteIngredient,
  }) : super(key: key);

  final Ingredient ingredient;
  final Function onIngredientChange;
  final int index;
  final Function deleteIngredient;

  @override
  State<IngredientInputCard> createState() =>
      _IngredientInputCardState(ingredient, onIngredientChange);
}

class _IngredientInputCardState extends State<IngredientInputCard> {
  Ingredient ingredient;
  Function onIngredientChange;
  _IngredientInputCardState(this.ingredient, this.onIngredientChange);

  late Function onIngredientTextChange;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Card(
              child: Row(
                children: [
                  Container(
                    width: 60,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'הקודם',
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'הוספת רכיבים',
                        style: kGroupHeadlineTextStyle,
                      ),
                    ),
                  ),
                  Container(
                    width: 60,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'הבא',
                        textAlign: TextAlign.end,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 4.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: buildTextField(
                            'מוצר', TextInputType.text, true, widget.index),
                      ),
                      Expanded(
                        flex: 1,
                        child: buildTextField(
                            'כמות', TextInputType.number, false, widget.index),
                      ),
                      IconButton(
                        onPressed: () {
                          widget.deleteIngredient(context, widget.index);
                        },
                        icon: Icon(
                          Icons.delete_outline,
                          color: kBakeZoneOrange,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.count(
                    physics: NeverScrollableScrollPhysics(),
                    childAspectRatio: (screenWidth / 4.0) / 34.0,
                    shrinkWrap: true,
                    crossAxisCount: 4,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    children:
                        IngredientsMeasureType.values.map((ingredientType) {
                      return ChoiceChip(
                        label: Padding(
                          padding: const EdgeInsets.only(bottom: 6.0),
                          child: Container(
                            width: double.infinity,
                            child: Text(
                              ingredientType.hebrewLabel,
                              style: kBodyTextStyle,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        selected: widget.ingredient.ingredientsMeasureType ==
                            ingredientType,
                        onSelected: (_) {
                          setState(() {
                            ingredient.ingredientsMeasureType = ingredientType;
                            FocusManager.instance.primaryFocus?.unfocus();
                            onIngredientChange(ingredient, widget.index);
                          });
                        },
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  TextField buildTextField(
      String hint, TextInputType textInputType, bool isTitle, int index) {
    return TextField(
      keyboardType: textInputType,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: hint,
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: kBakeZoneGreen)),
        labelStyle: GoogleFonts.assistant(
          color: kBakeZoneGreen,
        ),
      ),
      onChanged: (value) {
        print(value);
        isTitle ? ingredient.title = value : ingredient.amount = value;
        setState(() {
          onIngredientChange(ingredient, widget.index);
        });
      },
      minLines: 1,
      maxLines: 1,
    );
  }
}

// IngredientInputCard(
// ingredient: ingredient,
// onIngredientChange: _onIngredientChange,
// ),
