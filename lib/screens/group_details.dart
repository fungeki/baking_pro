import 'package:baking_pro/Utils/transitions.dart';
import 'package:baking_pro/objects/group.dart';
import 'package:baking_pro/screens/profile_page.dart';
import 'package:baking_pro/widgets/ProfileImageWidget.dart';
import 'package:baking_pro/widgets/group_selection_upper_banner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GroupDetails extends StatefulWidget {
  GroupDetails({required this.group});
  final Group group;
  final bool isFollowed = false;
  @override
  _GroupDetailsState createState() => _GroupDetailsState(group: group);
}

class _GroupDetailsState extends State<GroupDetails> {
  _GroupDetailsState({required this.group});
  final Group group;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(group.title),
        actions: [
          Padding(
            padding: EdgeInsets.fromLTRB(12.0, 12.0, 0.0, 12.0),
            child: InkWell(
              onTap: () {
                Navigator.of(context)
                    .push(createRouteForUpperTransition(page: ProfilePage()));
              },
              child: ProfileImageWidget(
                imageURI: 'images/bakeoff_winners_cropped.jpeg',
                radius: 30.0,
                size: 30.0,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: GroupSelectionUpperBanner(
              backgroundColor: group.color,
              displayedTitle: '',
              subTitle: '',
              isTitled: true,
              imageURI: group.imageURI,
            ),
          ),
          Expanded(flex: 5, child: Container())
        ],
      ),
    );
  }
}
