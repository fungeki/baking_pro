import 'package:baking_pro/Utils/transitions.dart';
import 'package:baking_pro/screens/profile_page.dart';
import 'package:flutter/material.dart';

import 'profile_image_widget.dart';

class BakeZoneAppbar extends StatefulWidget with PreferredSizeWidget {
  final bool isProfileImageLeading;
  final bool? isProfileImageTrailing;
  @override
  _BakeZoneAppbarState createState() =>
      _BakeZoneAppbarState(isProfileImageLeading, isProfileImageTrailing);

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  BakeZoneAppbar(
      {required this.isProfileImageLeading, this.isProfileImageTrailing});
}

class _BakeZoneAppbarState extends State<BakeZoneAppbar> {
  final bool isProfileImageLeading;
  final bool? isProfileImageTrailing;
  List<Widget> _appBarActions() {
    final isTrailing = isProfileImageTrailing ?? false;
    final actions = [
      ProfileImageForAppbar(
          isProfilePage: false,
          padding: EdgeInsets.only(left: 16.0, top: 12.0, bottom: 12.0))
    ];
    return isTrailing ? actions : [];
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      leading: isProfileImageLeading
          ? ProfileImageForAppbar(isProfilePage: !isProfileImageLeading)
          : BackButton(),
      title: SizedBox(
        height: kToolbarHeight,
        child: Image.asset(
          'images/banner_logo.png',
          fit: BoxFit.fitHeight,
        ),
      ),
      actions: _appBarActions(),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  _BakeZoneAppbarState(this.isProfileImageLeading, this.isProfileImageTrailing);
}

class ProfileImageForAppbar extends StatelessWidget {
  const ProfileImageForAppbar({
    this.padding,
    Key? key,
    required this.isProfilePage,
  }) : super(key: key);

  final bool isProfilePage;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.fromLTRB(0.0, 8.0, 16, 8.0),
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
