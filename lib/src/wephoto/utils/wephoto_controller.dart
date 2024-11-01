import 'package:flutter/material.dart';
import 'package:weaccess/src/wephoto/constant/package_constant.dart';
import 'package:weaccess/src/wephoto/data/url_data_model.dart';
import 'package:weaccess/src/wephoto/service/wephoto_controller_service.dart';

class WePhotoController extends ValueNotifier<URLDataModel> {
  WePhotoController({URLDataModel? data})
      : super(data ?? URLDataModel(imageUrl: ''));

  String get shortDescription => value.shortImageCaption ?? '';
  String get longDescription => value.longImageCaption ?? '';

  @protected
  void fetchDescription(URLDataModel data) {
    URLDataModel updatedValue;
    if (data != value) {
      updatedValue = value.copyWith(
        shortImageCaption: data.shortImageCaption,
        longImageCaption: data.longImageCaption,
      );
      value = updatedValue;
    } else {
      value = data;
    }
  }

  void setDescription(String description,
      {DescriptionType type = DescriptionType.short}) {
    final URLDataModel updatedValue;
    switch (type) {
      case DescriptionType.short:
        updatedValue = value.copyWith(
          shortImageCaption: description,
        );
        break;
      case DescriptionType.long:
        updatedValue = value.copyWith(
          longImageCaption: description,
        );
        break;
    }
    value = updatedValue;
    kURLBox.put(value.imageUrl, value);
  }
}
