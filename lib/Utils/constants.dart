import 'package:baking_pro/objects/group.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const kCoverHeight = 160.0;
const kProfileImageSize = 120.0;
const kProfileCardElevation = 8.0;
const kBlueTextColor = Color(0xff3d406b);
const kBakeZoneGreen = Color(0xFF81B29A);
const kBakeZoneGray = Color(0xFFAFAFAF);
const kBlackTextColor = Color(0xFF333333);
const kBakeZoneOrange = Color(0xFFEFBF7B);
const kIconForRecipes = Icons.ballot_outlined;
const kActionButtonOverImageSize = 40.0;
final kProfileHeaderTextStyle = GoogleFonts.assistant(
    fontSize: 18.0, fontWeight: FontWeight.w700, color: kBlackTextColor);
final kGroupHeadlineTextStyle = GoogleFonts.assistant(
    fontSize: 18.0, fontWeight: FontWeight.w700, color: kBlackTextColor);
final kBodyTextStyle = GoogleFonts.assistant(
  fontSize: 16.0,
  color: kBlackTextColor,
);
final kMinorDetailsTextStyle = GoogleFonts.assistant(
  fontSize: 12.0,
  color: kBlackTextColor,
);
final List<Group> groups = [
  Group(
    Colors.green,
    'קבוצת היכרות',
    'ספרו על עצמכם',
    'images/welcome.jpg',
    'images/video_placeholder.jpg',
    'חדשים בזון? למה לא תקפצו לומר שלום? בטוח משהו טוב מתבשל פה',
  ),
  Group(
    Colors.orangeAccent,
    'שיתוף מתכונים',
    'עשו זאת בעמצכם',
    'images/recipe_header.jpg',
    'images/video_placeholder_recipes.jpg',
    'מחמש דקות למתחילים ועד חמש שכבות למומחים, זה בידיים שלכם.',
  ),
  Group(
    Colors.yellow,
    'שיתוף השראות',
    'עם טיפה שינוי....',
    'images/welcome.jpg',
    'images/video_placeholder.jpg',
    'עשיתם מתכון עם שינויים ויצא לכם סוף? ספרו לנו',
  ),
  Group(
    Colors.pink,
    'קבוצת כשלונות',
    'מי מצטרף לסושי?',
    'images/fails_header.png',
    'images/video_placeholder_fails.jpg',
    'שריפות, התחממות גלובלית, החלפת סוכר במלח, האסונות המתוקים שלנו',
  ),
];

const OutlineInputBorder kBakeZoneTextFieldFocusBorder =
    OutlineInputBorder(borderSide: const BorderSide(color: kBakeZoneGreen));
