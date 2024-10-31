import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:tuple/tuple.dart';
import 'package:weaccess/src/weaccess.dart';
import 'package:weaccess/src/wephoto/constant/package_constant.dart';
import 'package:weaccess/src/wephoto/data/url_data_model.dart';
import 'package:weaccess/src/wephoto/service/api.dart';

class VisualRepresentationService {
  static final VisualRepresentationService instance =
      VisualRepresentationService._internal();

  VisualRepresentationService._internal();

  ApiServices apiServices = ApiServices();
  bool _isServiceRunning = false;
  Timer? _updateTimer;
  List<URLDataModel> _missingCaptionsList = [];
  bool _isCaptioningActive = false;
  final int updateIntervalSeconds = 30;

  void startService() {
    if (!_isServiceRunning) {
      _isServiceRunning = true;
      _missingCaptionsList = getMissingCaptionsList();
      if (_missingCaptionsList.isNotEmpty && !_isCaptioningActive) {
        _isCaptioningActive = true;
        updateMissingCaptions().then((_) {
          _isCaptioningActive = false;
        });
      }
      _updateTimer = Timer.periodic(Duration(seconds: updateIntervalSeconds),
          (timer) async {
        _missingCaptionsList = getMissingCaptionsList();
        if (_missingCaptionsList.isNotEmpty && !_isCaptioningActive) {
          _isCaptioningActive = true;
          await updateMissingCaptions().then((value) {
            _isCaptioningActive = false;
          });
        }
      });
    }
  }

  void stopService() {
    _updateTimer?.cancel();
    _isServiceRunning = false;
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

  Future<bool> updateMissingCaptions() async {
    for (int i = 0; i < _missingCaptionsList.length;) {
      var dataModel = _missingCaptionsList[i];
      if (dataModel.imageType == 'url') {
        final captions =
            await fetchShortCaptionsFromService(dataModel.imageUrl);
        dataModel = dataModel.copyWith(
          shortImageCaption: captions.item1,
          longImageCaption: captions.item2,
        );
        await kURLBox
            .put(dataModel.imageUrl, dataModel)
            .then((value, {Error? error}) {
          if (error != null) {
            if (kDebugMode) {
              print(
                  'Error while updating missing urlDataModelBox(${dataModel.imageUrl.replaceFirst('https://', '')}): $error');
            }
            i++;
            return;
          }
          if (WeAccess.activeLogger) {
            debugPrint('DataModel updated: ${dataModel.imageUrl}');
            debugPrint('DataModel updated: ${dataModel.shortImageCaption}');
            debugPrint('DataModel updated: ${dataModel.longImageCaption}');
          }
          i++;
        });
      } else if (dataModel.imageType == 'file') {
        final imageFile = await assetImageToFile(dataModel.imageUrl);
        final captions = await fetchImageDescriptionFile(imageFile);
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
          if (WeAccess.activeLogger) {
            debugPrint('DataModel updated: ${dataModel.imageUrl}');
            debugPrint('DataModel updated: ${dataModel.shortImageCaption}');
            debugPrint('DataModel updated: ${dataModel.longImageCaption}');
          }
          i++;
        });
      } else {
        break;
      }
    }
    return false;
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

  Future<Tuple2<String, String>> fetchShortCaptionsFromService(
      String imageUrl) async {
    final response =
        await apiServices.getImageDescriptionURL(imagePath: imageUrl);
    return response;
  }

  Future<Tuple2<String, String>> fetchImageDescriptionFile(
      File imageFile) async {
    final response =
        await apiServices.getImageDescriptionFile(image: imageFile);
    return response;
  }

  void dispose() {
    stopService();
    apiServices.dispose();
  }
}
