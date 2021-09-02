import 'package:flutter/material.dart';

const borderRadius = 32.0;

class GroupSelectionUpperBanner extends StatelessWidget {
  GroupSelectionUpperBanner(
      {Key? key,
      required this.backgroundColor,
      required this.displayedTitle,
      required this.isTitled,
      required this.subTitle,
      required this.imageURI});

  final bool isTitled;
  final Color backgroundColor;
  final String displayedTitle;
  final String subTitle;
  final String imageURI;

  BorderRadius radiusForDecoration() {
    return !isTitled
        ? BorderRadius.circular(borderRadius)
        : BorderRadius.vertical(bottom: Radius.circular(borderRadius));
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'upper_banner_${backgroundColor}',
      child: Material(
        type: MaterialType.transparency,
        child: Container(
          child: Column(
            children: [
              Spacer(
                flex: 3,
              ),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      displayedTitle,
                      style: TextStyle(
                        fontSize: 24.0,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      subTitle,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
            ],
          ),
          decoration: BoxDecoration(
            image:
                DecorationImage(image: AssetImage(imageURI), fit: BoxFit.cover),
            borderRadius: radiusForDecoration(),
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
        ),
      ),
    );
  }
}
