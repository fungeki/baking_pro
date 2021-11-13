import 'package:baking_pro/Utils/constants.dart';
import 'package:baking_pro/Utils/transitions.dart';
import 'package:baking_pro/objects/ingredient.dart';
import 'package:baking_pro/objects/ingredients_measure_type.dart';
import 'package:baking_pro/screens/recipes/input_recipe_reorderable_list.dart';
import 'package:baking_pro/widgets/expandable_fab.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class InputRecipeAddIngredients extends StatefulWidget {
  InputRecipeAddIngredients({
    Key? key,
    required this.backPressed,
    required this.nextPressed,
    this.onDelete,
  }) : super(key: key);

  final VoidCallback backPressed;
  final Function nextPressed;
  final VoidCallback? onDelete;
  bool displayDelete = false;

  @override
  _InputRecipeAddIngredientsState createState() =>
      _InputRecipeAddIngredientsState();
}

class _InputRecipeAddIngredientsState extends State<InputRecipeAddIngredients>
    with AutomaticKeepAliveClientMixin {
  List<Ingredient> ingredientsList = [Ingredient.empty()];
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  final _headlineTextFieldController = TextEditingController();
  final _listScrollController = ScrollController();
  List<TextEditingController> _titlesControllerList = [TextEditingController()];
  List<TextEditingController> _gramsControllerList = [TextEditingController()];
  List<TextEditingController> _amountControllerList = [TextEditingController()];

  bool focused = false;

  @override
  void initState() {
    super.initState();
  }

  void _onNextPressed() {
    FocusManager.instance.primaryFocus?.unfocus();
    String headline = _headlineTextFieldController.text;
    if (headline.length < 1) headline = 'כללי';
    widget.nextPressed(ingredientsList, headline);
  }

  List<Widget> buildActionWidgets() {
    List<Widget> actionBarWidgets = [];
    if (widget.displayDelete)
      actionBarWidgets.add(
        Container(
          child: IconButton(
            icon: Icon(
              Icons.delete_sweep_outlined,
              color: kBakeZoneOrange,
            ),
            onPressed: widget.onDelete!,
          ),
        ),
      );
    actionBarWidgets.add(Container(
      width: 60,
      child: TextButton(
        onPressed: () => _onNextPressed(),
        child: Text(
          'הבא',
          textAlign: TextAlign.end,
        ),
      ),
    ));
    return actionBarWidgets;
  }

  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      floatingActionButton: focused
          ? null
          : AnimatedContainer(
              duration: Duration(milliseconds: 300),
              child: ExpandableFab(
                distance: 70.0,
                children: [
                  ActionButton(
                    onPressed: () {},
                    icon: const Icon(Icons.format_size),
                  ),
                  ActionButton(
                    onPressed: () {
                      Navigator.of(context).push(createRouteForUpperTransition(
                          page: InputRecipeReorderableList(
                        isIngredient: true,
                        ingredients: ingredientsList,
                      )));
                    },
                    icon: const Icon(Icons.wifi_protected_setup_rounded),
                  ),
                ],
              ),
            ),
      body: Focus(
        onFocusChange: (isFocused) {
          setState(() {
            focused = isFocused;
          });
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
              child: Card(
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      child: TextButton(
                        onPressed: widget.backPressed,
                        child: Text(
                          'הקודם',
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Container(
                            height: 45, child: buildTextFieldForHeadline()),
                      ),
                    ),
                    ...buildActionWidgets(),
                  ],
                ),
              ),
            ),
            Expanded(
              child: AnimatedList(
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
                        titlesEditingControllers: _titlesControllerList,
                        amountEditingControllers: _amountControllerList,
                        gramsEditingControllers: _gramsControllerList,
                      ),
                    );
                  },
                  initialItemCount: 1),
            ),
          ],
        ),
      ),
    );
  }

  TextField buildTextFieldForHeadline() {
    return TextField(
      controller: _headlineTextFieldController,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'הכנסת כותרת לרכיבים (רשות)',
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: kBakeZoneGreen)),
        labelStyle: GoogleFonts.assistant(
          color: kBakeZoneGreen,
        ),
      ),
    );
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
                                titlesEditingControllers: _titlesControllerList,
                                amountEditingControllers: _amountControllerList,
                                gramsEditingControllers: _gramsControllerList,
                              ),
                            ),
                        duration: Duration(milliseconds: 300));
                    ingredientsList.removeAt(index);
                    _titlesControllerList.removeAt(index);
                    setState(() {
                      int currentItem = 0;
                      ingredientsList.forEach((element) {
                        _amountControllerList[currentItem].text =
                            element.amount ?? '';
                        _titlesControllerList[currentItem].text = element.title;
                        _gramsControllerList[currentItem].text =
                            element.grams ?? '';
                        currentItem++;
                      });
                    });
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
    if (index == ingredientsList.length - 1) {
      _titlesControllerList.add(TextEditingController());
      _amountControllerList.add(TextEditingController());
      _gramsControllerList.add(TextEditingController());
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
    required this.gramsEditingControllers,
    required this.amountEditingControllers,
    required this.titlesEditingControllers,
  }) : super(key: key);

  final Ingredient ingredient;
  final Function onIngredientChange;
  final int index;
  final Function deleteIngredient;
  List<TextEditingController> gramsEditingControllers;
  List<TextEditingController> amountEditingControllers;
  List<TextEditingController> titlesEditingControllers;
  @override
  State<IngredientInputCard> createState() =>
      _IngredientInputCardState(ingredient, onIngredientChange);
}

class _IngredientInputCardState extends State<IngredientInputCard>
    with AutomaticKeepAliveClientMixin {
  Ingredient ingredient;
  Function onIngredientChange;

  bool recycledTile = false;
  _IngredientInputCardState(this.ingredient, this.onIngredientChange);

  late Function onIngredientTextChange;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final screenWidth = MediaQuery.of(context).size.width;
    if (ingredient.title.length > 0) {
      recycledTile = true;
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
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
                        flex: 1,
                        child: buildTextField(
                            ingredient.ingredientsMeasureType.hebrewLabel,
                            TextInputType.number,
                            false,
                            widget.index,
                            null,
                            false,
                            widget.amountEditingControllers[widget.index]),
                      ),
                      Expanded(
                        flex: 3,
                        child: buildTextField(
                            'מוצר',
                            TextInputType.text,
                            true,
                            widget.index,
                            null,
                            false,
                            widget.titlesEditingControllers[widget.index]),
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
                AnimatedSwitcher(
                  transitionBuilder: (child, animation) {
                    final offsetAnimation = Tween<Offset>(
                            begin: Offset(0.0, -0.1), end: Offset(0.0, 0.0))
                        .animate(animation);
                    return SlideTransition(
                      position: offsetAnimation,
                      child: child,
                    );
                  },
                  duration: Duration(milliseconds: 175),
                  child:
                      widget.ingredient.ingredientsMeasureType.canHaveGramValue
                          ? Padding(
                              padding: EdgeInsets.all(8.0),
                              child: buildTextField(
                                  'ניתן להוסיף גרמים',
                                  TextInputType.text,
                                  false,
                                  widget.index,
                                  null,
                                  true,
                                  widget.gramsEditingControllers[widget.index]),
                            )
                          : SizedBox(),
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
      String hint,
      TextInputType textInputType,
      bool isTitle,
      int index,
      int? maxLength,
      bool isGrams,
      TextEditingController controller) {
    return TextField(
      maxLength: maxLength,
      keyboardType: textInputType,
      controller: controller,
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
        if (isGrams) {
          ingredient.grams = value;
        } else
          isTitle ? ingredient.title = value : ingredient.amount = value;
        setState(() {
          onIngredientChange(ingredient, widget.index);
        });
      },
      minLines: 1,
      maxLines: 1,
    );
  }

  @override
  bool get wantKeepAlive => true;
}

// IngredientInputCard(
// ingredient: ingredient,
// onIngredientChange: _onIngredientChange,
// ),
