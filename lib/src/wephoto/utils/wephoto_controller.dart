import 'package:flutter/material.dart';

class WePhotoController extends ChangeNotifier {
  String _description = 'WeAccess';

  String get description => _description;

  void setDescription(String description) {
    _description = description;
    notifyListeners();
  }
}
