import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path/path.dart' as p;
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:weaccess/src/wephoto/constant/package_constant.dart';
import 'package:weaccess/src/wephoto/data/url_data_model.dart';
import 'package:weaccess/src/wephoto/service/visual_representation_service.dart';
import 'package:weaccess/src/wephoto/utils/wephoto_controller.dart';

class WePhotoService {
  static late VisualRepresentationService _visualRepresentationService;

  static void processToImage(ImageProvider image) {
    _processToImage(image);
  }

  static void clearCache() {
    _clearCache();
  }

  static void addDescriptionToController(
      WePhotoController? controller, String description) {
    if (controller != null) {
      controller.setDescription(description);
    }
  }

  static String getImageCaption(
      Box<URLDataModel> box, ImageProvider image, String descriptionType) {
    if (image is AssetImage) {}
    if (image is NetworkImage) {
      final imageUrl = image.url;
      final urlDataModel = box.get(imageUrl);

      if (urlDataModel != null) {
        return urlDataModel.shortImageCaption ?? '';
      }
    }
    return 'No Image Caption available';
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
    _visualRepresentationService = VisualRepresentationService();
    _visualRepresentationService.addUrlImageData(urlDataModel);
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
    final imageFile = await assetImageToFile(imagePath);
    _visualRepresentationService = VisualRepresentationService();
    _visualRepresentationService.addFileImageData(
        data: urlDataModel, file: imageFile);
  }

  static Future<File> assetImageToFile(String imagePath) async {
    final Directory directory = await getTemporaryDirectory();
    final String path = '${directory.path}/wephoto';
    final Directory wephotoDirectory = Directory(path);
    if (!(await wephotoDirectory.exists())) {
      await wephotoDirectory.create(recursive: true);
    }
    ByteData byteData = await rootBundle.load(imagePath);
    Uint8List uint8list = byteData.buffer.asUint8List();
    final File file = File('$path/${p.basename(imagePath)}');
    return await file.writeAsBytes(uint8list);
  }

  static void _clearCache() {
    kURLBox.clear();
  }

  static void dispose() {
    _visualRepresentationService.dispose();
  }
}
