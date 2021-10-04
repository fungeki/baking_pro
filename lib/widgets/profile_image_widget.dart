import 'package:flutter/material.dart';

class ProfileImageWidget extends StatelessWidget {
  final String imageURI;
  final double radius;
  final double size;

  ProfileImageWidget(
      {required this.imageURI, required this.radius, required this.size});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Image.asset(
        imageURI,
        fit: BoxFit.cover,
        height: size,
        width: size,
      ),
    );
  }
}
