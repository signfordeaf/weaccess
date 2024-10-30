import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:tuple/tuple.dart';
import 'package:weaccess/src/wephoto/constant/package_constant.dart';
import 'package:weaccess/src/wephoto/data/url_data_model.dart';
import 'package:weaccess/src/wephoto/service/api.dart';

class VisualRepresentationService {
  ApiServices apiServices = ApiServices();

  Future<void> addUrlImageData(URLDataModel data) async {
    await updateMissingCaptions();
  }

  Future<void> addFileImageData(
      {required URLDataModel data, required File file}) async {
    await updateMissingCaptions(imageFile: file);
  }

  URLDataModel? getUrlData(String imageUrl) {
    return kURLBox.get(imageUrl);
  }

  List<URLDataModel> getMissingCaptionsList() {
    return kURLBox.values.where((urlDataModel) {
      return urlDataModel.shortImageCaption == null ||
          urlDataModel.longImageCaption == null ||
          urlDataModel.shortImageCaption == 'No Image Caption available' ||
          urlDataModel.longImageCaption == 'No Image Caption available';
    }).toList();
  }

  Future<void> updateMissingCaptions({File? imageFile}) async {
    final missingCaptionsList = getMissingCaptionsList();

    for (int i = 0; i < missingCaptionsList.length;) {
      var dataModel = missingCaptionsList[i];

      if (dataModel.imageType == 'url') {
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
      } else if (dataModel.imageType == 'file') {
        final captions = await fetchImageDescriptionFile(imageFile ?? File(''));
        dataModel = dataModel.copyWith(
          shortImageCaption: captions.item1,
          longImageCaption: captions.item2,
        );
        await kURLBox
            .put(dataModel.imageUrl, dataModel)
            .then((value, {Error? error}) {
          if (error != null) {
            debugPrint(
                'Error while updating missing urlDataModelBox(${dataModel.imageUrl.replaceFirst('https://', '')}): $error');
            i++;
            return;
          }
          if (kDebugMode) {
            print('DataModel updated: ${dataModel.imageUrl}');
            print('DataModel updated: ${dataModel.shortImageCaption}');
            print('DataModel updated: ${dataModel.longImageCaption}');
          }
          i++;
        });
      } else {
        break;
      }
    }
  }

  Future<String> fetchShortCaptionsFromService(String imageUrl) async {
    final response = await apiServices.getImageCaption(imagePath: imageUrl);
    return response;
  }

  Future<String> fetchLongCaptionsFromService(String imageUrl) async {
    final response = await apiServices.getLongImageCaption(imagePath: imageUrl);
    return response;
  }

  Future<Tuple2<String, String>> fetchImageDescriptionFile(
      File imageFile) async {
    final response =
        await apiServices.getImageDescriptionFile(image: imageFile);
    return response;
  }

  void dispose() {
    apiServices.dispose();
  }
}
