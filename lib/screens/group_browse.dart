import 'package:baking_pro/objects/group.dart';
import 'package:baking_pro/screens/group_details.dart';
import 'package:baking_pro/widgets/group_selection_lower_banner.dart';
import 'package:baking_pro/widgets/group_selection_upper_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

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

class GroupBrowse extends StatefulWidget {
  @override
  _GroupBrowseState createState() => _GroupBrowseState();
}

class _GroupBrowseState extends State<GroupBrowse> {
  final _pageController = PageController(viewportFraction: 0.8);
  double page = 0.0;
  static const int _swipeSensativity = 8;

  void _onTap(Group group) {
    Navigator.of(context).push(PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 500),
        pageBuilder: (context, animation, _) {
          return FadeTransition(
            opacity: animation,
            child: GroupDetails(
              group: group,
            ),
          );
        }));
  }

  void _listenScroll() {
    setState(() {
      page = _pageController.page ?? 0.0;
    });
  }

  @override
  void initState() {
    _pageController.addListener(_listenScroll);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.removeListener(_listenScroll);
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration:
            BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor),
        child: Column(mainAxisSize: MainAxisSize.max, children: [
          Expanded(
              child: PageView.builder(
                  itemCount: groups.length,
                  controller: _pageController,
                  itemBuilder: (context, index) {
                    final percent = (page - index).abs();
                    final double mOpacity = 1 - percent.clamp(0.0, 0.5);
                    Alignment alignment = index > page
                        ? Alignment.topRight
                        : Alignment.topLeft; //change here for english
                    return Transform(
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..rotateY(vector.radians(45 * percent)),
                      alignment: alignment,
                      child: Opacity(
                        opacity: mOpacity,
                        child: DoubleCardsLayout(
                          displayedGroup: groups[index],
                          swipeSensativity: _swipeSensativity,
                          onTap: () {
                            _onTap(groups[index]);
                          },
                        ),
                      ),
                    );
                  })),
        ]));
  }
}

class DoubleCardsLayout extends StatelessWidget {
  final Group displayedGroup;
  final int swipeSensativity;
  final VoidCallback onTap;
  DoubleCardsLayout(
      {required this.displayedGroup,
      required this.swipeSensativity,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          children: [
            Expanded(
              flex: 7,
              child: GroupSelectionUpperBanner(
                backgroundColor: displayedGroup.color,
                displayedTitle: displayedGroup.title,
                subTitle: displayedGroup.subTitle,
                isTitled: false,
                imageURI: displayedGroup.imageURI,
              ),
            ),
            Spacer(
              flex: 1,
            ),
            Expanded(
              flex: 20,
              child: GroupSelectionLowerBanner(
                videoURI: displayedGroup.videoURI,
                description: displayedGroup.description,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
