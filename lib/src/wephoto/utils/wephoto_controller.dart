import 'package:flutter/material.dart';
import 'package:weaccess/src/wephoto/data/url_data_model.dart';
import 'package:weaccess/src/wephoto/service/wephoto_controller_service.dart';

class WePhotoController extends ValueNotifier<URLDataModel> {
  WePhotoController({URLDataModel? data})
      : super(data ?? URLDataModel(imageUrl: ''));

  String get shortDescription => value.shortImageCaption ?? '';
  String get longDescription => value.longImageCaption ?? '';

  @protected
  void fetchDescription(String description,
      {DescriptionType type = DescriptionType.short}) {
    URLDataModel updatedValue;
    if (type == DescriptionType.short) {
      updatedValue = value.copyWith(shortImageCaption: description);
    } else {
      updatedValue = value.copyWith(longImageCaption: description);
    }
    value = updatedValue;
  }
}
