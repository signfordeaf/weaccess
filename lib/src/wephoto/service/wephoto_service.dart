// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weaccess/src/wephoto/constant/package_constant.dart';
import 'package:weaccess/src/wephoto/data/url_data_model.dart';
import 'package:weaccess/src/wephoto/service/visual_representation_service.dart';
import 'package:weaccess/src/wephoto/utils/wephoto_controller.dart';

class WePhotoService {
  static void processToImage(ImageProvider image) {
    _processToImage(image);
  }

  static void clearCache() {
    _clearCache();
  }

  static void addDescriptionToController(
      WePhotoController? controller, String description) {
    if (controller != null) {}
  }

  static String getImageCaption(
      Box<URLDataModel> box, ImageProvider image, String descriptionType,
      {WePhotoController? controller}) {
    if (image is AssetImage) {
      final imagePath = image.assetName;
      final urlDataModel = box.get(imagePath);
      if (urlDataModel != null) {
        if (controller != null) {
          _fillControllerDescription(controller, urlDataModel);
        }
        return descriptionType == 'short'
            ? urlDataModel.shortImageCaption ?? ''
            : urlDataModel.longImageCaption ?? '';
      }
    }
    if (image is NetworkImage) {
      final imageUrl = image.url;
      final urlDataModel = box.get(imageUrl);

      if (urlDataModel != null) {
        if (controller != null) {
          _fillControllerDescription(controller, urlDataModel);
        }
        return descriptionType == 'short'
            ? urlDataModel.shortImageCaption ?? ''
            : urlDataModel.longImageCaption ?? '';
      }
    }
    return 'No Image Caption available';
  }

  static void _fillControllerDescription(
    WePhotoController controller,
    URLDataModel data,
  ) {
    controller.fetchDescription(data);
  }

  static void _processToImage(ImageProvider image) {
    switch (image) {
      case AssetImage _:
        final imagePath = image.assetName;
        _saveImageToCacheFile(imagePath);
        break;
      case NetworkImage _:
        final imageUrl = image.url;
        _saveImageToCache(imageUrl);
        return;
      default:
        if (kDebugMode) throw Exception('Image type not supported');
    }
  }

  static void _saveImageToCache(String imageSource) {
    final existingUrls = kURLBox.values
        .where((element) => element.imageUrl == imageSource)
        .toList();

    URLDataModel urlDataModel =
        URLDataModel(imageUrl: imageSource, imageType: 'url');
    if (existingUrls.isNotEmpty) {
      urlDataModel = urlDataModel.copyWith(
        shortImageCaption: existingUrls.first.shortImageCaption,
        longImageCaption: existingUrls.first.longImageCaption,
      );
    }
    kURLBox.put(urlDataModel.imageUrl, urlDataModel);
    VisualRepresentationService.instance.startService();
  }

  static void _saveImageToCacheFile(String imagePath) async {
    final existingUrls = kURLBox.values
        .where((element) => element.imageUrl == imagePath)
        .toList();
    URLDataModel urlDataModel =
        URLDataModel(imageUrl: imagePath, imageType: 'file');
    if (existingUrls.isNotEmpty) {
      urlDataModel = urlDataModel.copyWith(
        shortImageCaption: existingUrls.first.shortImageCaption,
        longImageCaption: existingUrls.first.longImageCaption,
      );
    }
    kURLBox.put(urlDataModel.imageUrl, urlDataModel);
    VisualRepresentationService.instance.startService();
  }

  static void _clearCache() {
    kURLBox.clear();
  }

  static void dispose() {
    VisualRepresentationService.instance.dispose();
  }
}
