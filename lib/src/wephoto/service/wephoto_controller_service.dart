import 'package:flutter/foundation.dart';
import 'package:weaccess/src/wephoto/constant/package_constant.dart';

enum DescriptionType { short, long }

class WePhotoControllerService {
  @protected
  String _source = '';
  @protected
  String _longDescription = 'WeAccess';
  @protected
  String _shortDescription = 'WeAccess';

  WePhotoControllerService({required String source}) {
    _source = source;
    _fetchImageCaption(_source);
  }

  String get source => _source;
  String get shortDescription => _shortDescription;
  String get longDescription => _longDescription;

  @protected
  void setDescription(String description,
      {DescriptionType type = DescriptionType.short}) {
    switch (type) {
      case DescriptionType.short:
        _shortDescription = description;
        _setBoxDescription(description, _source, DescriptionType.short);
        break;
      case DescriptionType.long:
        _longDescription = description;
        _setBoxDescription(description, _source, DescriptionType.long);
        break;
    }
  }

  @protected
  void _setBoxDescription(
      String newDescription, String source, DescriptionType type) {
    final dataModel =
        kURLBox.values.firstWhere((element) => element.imageUrl == source);
    if (type == DescriptionType.short) {
      dataModel.copyWith(shortImageCaption: newDescription);
    } else {
      dataModel.copyWith(longImageCaption: newDescription);
    }
    kURLBox.put(dataModel.imageUrl, dataModel);
  }

  @protected
  void _fetchImageCaption(String source) {
    final dataModel = kURLBox.get(source);
    if (dataModel != null) {
      _shortDescription = dataModel.shortImageCaption ?? '';
      _longDescription = dataModel.longImageCaption ?? '';
    }
  }
}
