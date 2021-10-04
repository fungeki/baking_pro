import 'package:flutter/material.dart';

class ImageDetails extends StatelessWidget {
  final String imageURI;
  final String? index;

  ImageDetails({required this.imageURI, this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Hero(
            tag: imageURI,
            child: Image.asset(
              imageURI,
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),
        ),
      ),
    );
  }
}
