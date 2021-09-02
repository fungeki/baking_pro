import 'package:flutter/material.dart';

class GroupSelectionLowerBanner extends StatefulWidget {
  final String videoURI;
  final String description;

  GroupSelectionLowerBanner(
      {required this.videoURI, required this.description});

  @override
  _GroupSelectionLowerBannerState createState() =>
      _GroupSelectionLowerBannerState(videoURI, description);
}

class _GroupSelectionLowerBannerState extends State<GroupSelectionLowerBanner> {
  final String imageURI;
  final String description;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            flex: 6,
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(32.0)),
              child: Image(
                image: AssetImage(imageURI),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                description,
                style: TextStyle(fontSize: 16.0, color: Colors.white),
              ),
            ),
          )
        ],
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.55),
            spreadRadius: 5,
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      width: double.infinity,
    );
  }

  _GroupSelectionLowerBannerState(this.imageURI, this.description);
}
