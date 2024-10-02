import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:weaccess/src/wephoto/constant/package_constant.dart';
import 'package:weaccess/src/wephoto/data/url_data_model.dart';
import 'package:weaccess/src/wephoto/service/api.dart';

class VisualRepresentationService {
  ApiServices apiServices = ApiServices();

  Future<void> addUrlImageData(URLDataModel data) async {
    await updateMissingCaptions();
  }

  URLDataModel? getUrlData(String imageUrl) {
    return kURLBox.get(imageUrl);
  }

  List<URLDataModel> getMissingCaptionsList() {
    return kURLBox.values.where((urlDataModel) {
      return urlDataModel.shortImageCaption == null ||
          urlDataModel.longImageCaption == null;
    }).toList();
  }

  Future<void> updateMissingCaptions() async {
    final missingCaptionsList = getMissingCaptionsList();

    for (int i = 0; i < missingCaptionsList.length;) {
      var dataModel = missingCaptionsList[i];
      try {
        if (dataModel.shortImageCaption == null) {
          final captions =
              await fetchShortCaptionsFromService(dataModel.imageUrl);
          print('shortCaptions: $captions');
          dataModel = dataModel.copyWith(shortImageCaption: captions);
        }
        if (dataModel.longImageCaption == null) {
          final longCaptions =
              await fetchLongCaptionsFromService(dataModel.imageUrl);
          print('longCaptions: $longCaptions');
          dataModel = dataModel.copyWith(longImageCaption: longCaptions);
        }
        await kURLBox
            .put(dataModel.imageUrl, dataModel)
            .then((value, {Error? error}) {
          if (error != null) {
            print(
                'Error while updating missing urlDataModelBox(${dataModel.imageUrl.replaceFirst('https://', '')}): $error');
            return;
          }
          print('DataModel updated: ${dataModel.imageUrl}');
          print('DataModel updated: ${dataModel.shortImageCaption}');
          print('DataModel updated: ${dataModel.longImageCaption}');
          i++;
        });
      } catch (e) {
        if (kDebugMode) {
          print(
              'Error while updating missing captions(${dataModel.imageUrl.replaceFirst('https://', '')}): $e');
        }
      }
    }
  }

  /* Future<void> updateMissingCaptions() async {
    final missingCaptionsList = getMissingCaptionsList();

    for (var dataModel in missingCaptionsList) {
      try {
        if (dataModel.shortImageCaption == null ||
            (dataModel.shortImageCaption ?? '').isEmpty) {
          final captions =
              await fetchShortCaptionsFromService(dataModel.imageUrl);
          print('shortCaptions: $captions');
          dataModel = dataModel.copyWith(shortImageCaption: captions);
        }
        if (dataModel.longImageCaption == null ||
            dataModel.longImageCaption!.isEmpty) {
          final longCaptions =
              await fetchLongCaptionsFromService(dataModel.imageUrl);
          print('longCaptions: $longCaptions');
          dataModel = dataModel.copyWith(longImageCaption: longCaptions);
        }
        await kURLBox.put(dataModel.imageUrl, dataModel);
      } catch (e) {
        if (kDebugMode) {
          print(
              'Error while updating missing captions(${dataModel.imageUrl.replaceFirst('https://', '')}): $e');
        }
      }
    }
  }
 */
  Future<String> fetchShortCaptionsFromService(String imageUrl) async {
    final response = await apiServices.getImageCaption(imagePath: imageUrl);
    return response;
  }

  Future<String> fetchLongCaptionsFromService(String imageUrl) async {
    final response = await apiServices.getLongImageCaption(imagePath: imageUrl);
    return response;
  }

  void dispose() {
    apiServices.dispose();
  }
}
