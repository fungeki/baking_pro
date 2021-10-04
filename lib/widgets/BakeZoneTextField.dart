import 'package:baking_pro/Utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BakeZoneInputTextField extends StatelessWidget {
  BakeZoneInputTextField({
    Key? key,
    required this.minLines,
    required this.maxLines,
    required this.hint,
    this.textInputType,
    this.onSubmitted,
    this.onChanged,
  }) : super(key: key);

  final int maxLines;
  final int minLines;
  final String hint;
  final TextInputType? textInputType;
  final Function? onSubmitted;
  final Function? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: (String value) => onSubmitted,
      onChanged: (String value) => onChanged,
      maxLines: maxLines,
      minLines: minLines,
      keyboardType: textInputType ?? TextInputType.text,
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
}
