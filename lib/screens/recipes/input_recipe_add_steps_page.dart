import 'dart:io';

import 'package:baking_pro/Utils/constants.dart';
import 'package:baking_pro/objects/recipe_step.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';

class InputRecipeAddStepsPage extends StatefulWidget {
  InputRecipeAddStepsPage(
      {Key? key,
      required this.backPressed,
      required this.displayDelete,
      required this.nextPressed,
      this.onDelete})
      : super(key: key);

  final VoidCallback backPressed;
  bool displayDelete;
  final Function nextPressed;
  final VoidCallback? onDelete;
  @override
  _InputRecipeAddStepsPageState createState() =>
      _InputRecipeAddStepsPageState();
}

class _InputRecipeAddStepsPageState extends State<InputRecipeAddStepsPage>
    with AutomaticKeepAliveClientMixin {
  List<RecipeStep> steps = [RecipeStep.empty()];
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  final _headlineTextFieldController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  final _listScrollController = ScrollController();

  _deleteItem(BuildContext context, int index) {
    FocusManager.instance.primaryFocus?.unfocus();
    if (index == steps.length - 1) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("שלב אחרון נשאר ריק, אין צורך במחיקה"),
      ));
      return;
    }
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text('מחיקת שלב'),
              content: Text('האם למחוק את השלב מהרשימה?'),
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
                            child: buildStepInputCard(index, context)),
                        duration: Duration(milliseconds: 300));
                    steps.removeAt(index);
                  },
                  child: const Text(
                    'מחיקה',
                    style: TextStyle(color: kBakeZoneOrange),
                  ),
                ),
              ],
            ));
  }

  Future<File?> _selectImageFromGallery() async {
    try {
      final status = await Permission.photos.request();
      if (status == PermissionStatus.granted) {
        final XFile? image =
            await _picker.pickImage(source: ImageSource.gallery);
        if (image == null) return null;
        final imagePathFile = File(image.path);
        return imagePathFile;
      } else {
        return null;
      }
    } on PlatformException catch (e) {
      print('failed to upload image: $e');
      return null;
    }
  }

  _addStep(int index) {
    if (index == steps.length - 1) {
      steps.add(RecipeStep.empty());
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
  }

  TextField buildTextFieldForHeadline() {
    return TextField(
      controller: _headlineTextFieldController,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'כותרת לשלבי הכנה (רשות)',
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: kBakeZoneGreen)),
        labelStyle: GoogleFonts.assistant(
          color: kBakeZoneGreen,
        ),
      ),
    );
  }

  void _onNextPressed() {
    FocusManager.instance.primaryFocus?.unfocus();
    String headline = _headlineTextFieldController.text;
    if (headline.length < 1) headline = 'כללי';
    widget.nextPressed(steps, headline);
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
            onPressed: widget.onDelete,
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
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Card(
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
                  ...buildActionWidgets()
                ],
              ),
            ),
            Expanded(
                child: AnimatedList(
              controller: _listScrollController,
              key: listKey,
              initialItemCount: 1,
              itemBuilder: (BuildContext context, int index,
                  Animation<double> animation) {
                return SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(1, 0),
                      end: Offset(0, 0),
                    ).animate(animation),
                    child: buildStepInputCard(index, context));
              },
            )),
          ],
        ),
      ),
    );
  }

  Card buildStepInputCard(int index, BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: TextField(
                    maxLength: 250,
                    maxLines: null,
                    onChanged: (text) {
                      steps[index].instructions = text;
                      _addStep(index);
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'תיאור שלב',
                      labelStyle: GoogleFonts.assistant(
                        color: kBakeZoneGreen,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: kBakeZoneGreen),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => _deleteItem(context, index),
                  icon: Icon(
                    Icons.delete_outline,
                    color: kBakeZoneOrange,
                  ),
                ),
              ],
            ),
            steps[index].image == null
                ? Row(
                    children: [
                      TextButton.icon(
                        onPressed: () async {
                          _onSelectImagePressed(index);
                        },
                        label: Text(
                          'הוספת תמונה',
                        ),
                        icon: Icon(
                          Icons.add_a_photo,
                          color: kBakeZoneGray,
                        ),
                      ),
                    ],
                  )
                : InkWell(
                    onTap: () async {
                      _onSelectImagePressed(index);
                    },
                    child: Container(
                      width: double.infinity,
                      height: (MediaQuery.of(context).size.width / 2.5),
                      child: Image.file(
                        steps[index].image!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  void _onSelectImagePressed(int index) {
    _selectImageFromGallery().then((file) {
      setState(() {
        if (file != null) _addStep(index);
        steps[index].image = file;
      });
    });
  }

  @override
  bool get wantKeepAlive => true;
}
