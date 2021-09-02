import 'package:baking_pro/Utils/transitions.dart';
import 'package:baking_pro/screens/profile_page.dart';
import 'package:flutter/material.dart';

import 'ProfileImageWidget.dart';

class BakeZoneAppbar extends StatefulWidget with PreferredSizeWidget {
  final bool isProfilePage;
  @override
  _BakeZoneAppbarState createState() => _BakeZoneAppbarState(isProfilePage);

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  BakeZoneAppbar({required this.isProfilePage});
}

class _BakeZoneAppbarState extends State<BakeZoneAppbar> {
  final bool isMyProfilePage;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      leading: isMyProfilePage
          ? BackButton()
          : ProfileImageForAppbar(isProfilePage: isMyProfilePage),
      title: SizedBox(
        height: kToolbarHeight,
        child: Image.asset(
          'images/banner_logo.png',
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  _BakeZoneAppbarState(this.isMyProfilePage);
}

class ProfileImageForAppbar extends StatelessWidget {
  const ProfileImageForAppbar({
    Key? key,
    required this.isProfilePage,
  }) : super(key: key);

  final bool isProfilePage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 8.0, 16, 8.0),
      child: InkWell(
        onTap: () {
          if (!isProfilePage) {
            Navigator.of(context)
                .push(createRouteForUpperTransition(page: ProfilePage()));
          }
        },
        child: ProfileImageWidget(
          imageURI: 'images/bakeoff_winners_cropped.jpeg',
          radius: 30.0,
          size: 30.0,
        ),
      ),
    );
  }
}
