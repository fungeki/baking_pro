import 'package:flutter/material.dart';

class Group {
  final Color _color;
  final String _title;
  final String _subTitle;
  final String _imageURI;
  final String _videoURI;
  final String _description;

  Group(this._color, this._title, this._subTitle, this._imageURI,
      this._videoURI, this._description);

  String get videoURI => _videoURI;

  String get description => _description;

  String get imageURI => _imageURI;

  String get subTitle => _subTitle;

  String get title => _title;

  Color get color => _color;
}
