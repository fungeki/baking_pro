import 'dart:io';
import 'package:baking_pro/Utils/constants.dart';
import 'package:baking_pro/objects/recipe_difficulty_type.dart';
import 'package:baking_pro/objects/recipe_post.dart';
import 'package:baking_pro/widgets/BakeZoneTextField.dart';
import 'package:baking_pro/widgets/bakezone_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';

class InputRecipeInitDataPage extends StatefulWidget {
  const InputRecipeInitDataPage({Key? key, required this.nextPressed})
      : super(key: key);

  final Function nextPressed;
  @override
  _InputRecipeInitDataPageState createState() =>
      _InputRecipeInitDataPageState();
}

class _InputRecipeInitDataPageState extends State<InputRecipeInitDataPage> {
  final ImagePicker _picker = ImagePicker();
  File? thumbImage;
  File? coverImage;
  RecipeDifficultyType difficulty = RecipeDifficultyType.values[0];

  final headlineTextStyle = GoogleFonts.assistant(
    color: kBakeZoneGreen,
    fontSize: 16,
  );
  //TextField Controllers:
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  //work time controllers:
  TextEditingController workMinutesController = TextEditingController();
  TextEditingController workHoursController = TextEditingController();
  TextEditingController workDaysController = TextEditingController();
  //total time controllers:
  TextEditingController totalMinutesController = TextEditingController();
  TextEditingController totalHoursController = TextEditingController();
  TextEditingController totalDaysController = TextEditingController();

  @override
  void initState() {
    super.initState();
    totalDaysController.text = '00';
    totalHoursController.text = '00';
    totalMinutesController.text = '00';
    workHoursController.text = '00';
    workMinutesController.text = '00';
    workDaysController.text = '00';
  }

  bool _validateInput() {
    if (titleController.text.length < 3) return false;
    if (descriptionController.text.length < 3) return false;
    return true;
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

  double _thumbImageSize(BuildContext context) {
    return (MediaQuery.of(context).size.width / 2.5);
  }

  String hint = 'מיאו';
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          Card(
            child: Row(
              children: [
                Container(
                  width: 60,
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      'יצירת מתכון',
                      style: kGroupHeadlineTextStyle,
                    ),
                  ),
                ),
                Container(
                  width: 60,
                  child: TextButton(
                    onPressed: () {
                      _onNextPressed();
                    },
                    child: Text(
                      'הבא',
                      textAlign: TextAlign.end,
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    flex: 2,
                    child: GestureDetector(
                      onTap: () async {
                        _selectImageFromGallery().then((image) {
                          setState(() {
                            coverImage = image;
                          });
                        });
                      },
                      child: Container(
                        height: _thumbImageSize(context),
                        width: double.infinity,
                        child: coverImage != null
                            ? Image.file(
                                coverImage!,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                'images/recipe_cover_add_button.jpg',
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16.0, left: 8.0, right: 8.0),
                    child: freeWritingTextFieldBuilder(
                        'שם המתכון', titleController),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16.0, left: 8.0, right: 8.0),
                    child: freeWritingTextFieldBuilder(
                        'תיאור המתכון', descriptionController),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: buildTimeInput('זמן עבודה', true),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: buildTimeInput('זמן הכנה', false),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'בחירת רמת קושי',
                      style: headlineTextStyle,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: GridView.count(
                        crossAxisSpacing: 8,
                        childAspectRatio: (screenWidth / 4.0) / 34.0,
                        crossAxisCount: RecipeDifficultyType.values.length,
                        children: RecipeDifficultyType.values.map((e) {
                          return ChoiceChip(
                            selected: e == difficulty,
                            label: Container(
                              width: double.infinity,
                              child: Text(
                                e.hebrewLabel,
                                style: kBodyTextStyle,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextField freeWritingTextFieldBuilder(
      String hint, TextEditingController controller) {
    return TextField(
      minLines: 1,
      maxLines: 2,
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: hint,
        labelStyle: GoogleFonts.assistant(
          color: kBakeZoneGreen,
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: kBakeZoneGreen)),
      ),
    );
  }

  Column buildTimeInput(String title, bool isWorkTime) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: Text(
            title,
            style: headlineTextStyle,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: kBakeZoneGray),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildTimeInputTextfield(isWorkTime
                    ? workMinutesController
                    : totalMinutesController),
                Text(
                  ':',
                  style: kBodyTextStyle,
                ),
                buildTimeInputTextfield(
                    isWorkTime ? workHoursController : totalHoursController),
                Text(
                  ':',
                  style: kBodyTextStyle,
                ),
                buildTimeInputTextfield(
                    isWorkTime ? workDaysController : totalDaysController),
              ]),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('דקות'),
            Text('שעות'),
            Text('ימים'),
          ],
        ),
      ],
    );
  }

  Expanded buildTimeInputTextfield(TextEditingController controller) {
    return Expanded(
      child: FocusScope(
        child: Focus(
          onFocusChange: (focus) {
            if (focus) {
              controller.text = '';
            } else {
              if (controller.text == '') controller.text = '00';
            }
          },
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: kBakeZoneGreen, width: 2)),
              focusColor: kBakeZoneGreen,
              labelStyle: GoogleFonts.assistant(
                color: kBakeZoneGreen,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onNextPressed() {
    final title = titleController.text;
    final description = descriptionController.text;
    int workMinutes = int.parse(workMinutesController.text);
    workMinutes += (int.parse(workHoursController.text) * 60);
    workMinutes += (int.parse(workDaysController.text) * 60 * 24);
    int totalMinutes = int.parse(totalMinutesController.text);
    totalMinutes += (int.parse(totalHoursController.text) * 60);
    totalMinutes += (int.parse(totalDaysController.text) * 60 * 24);
    RecipePost(
        title: title,
        description: description,
        totalTime: totalMinutes,
        workTime: workMinutes);
  }
}
