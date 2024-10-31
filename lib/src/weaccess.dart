import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:weaccess/src/wephoto/constant/package_constant.dart';
import 'package:weaccess/src/wephoto/data/url_data_model.dart';

class WeAccess {
  static final WeAccess _instance = WeAccess._internal();
  late String _apiKey;
  bool _isInitialized = false;
  bool _activeLogger = false;

  factory WeAccess() {
    return _instance;
  }

  WeAccess._internal();

  /// Initialize the WeAccess package with the [apiKey].
  ///
  /// This method should be called before using any other methods in the package.
  ///
  /// [apiKey] is the API key provided by WeAccess.
  ///
  /// This function [WidgetsFlutterBinding.ensureInitialized] contains.
  static Future<void> init({required String apiKey, bool? activeLogger}) async {
    _instance._apiKey = apiKey;
    _instance._activeLogger = activeLogger ?? false;
    _instance._isInitialized = true;
    WidgetsFlutterBinding.ensureInitialized();
    await _initializeHiveBox();
  }

  static void ensureInitialized() {
    if (!_instance._isInitialized) {
      if (kDebugMode) {
        throw Exception(
            'WeAccess has not been initialized. Please call WeAccess.init() before using the package.');
      }
    }
  }

  static Future<void> _initializeHiveBox() async {
    final directory = await getApplicationDocumentsDirectory();
    final hiveDirectory = '${directory.path}/$kHiveDirectory';
    final directoryExists = await Directory(hiveDirectory).exists();
    if (!directoryExists) {
      await Directory(hiveDirectory).create(recursive: true);
    }
    await Hive.initFlutter(hiveDirectory);
    Hive.registerAdapter(URLDataModelAdapter());
    await Hive.openBox<URLDataModel>(kHiveUrlBoxName);
  }

  static bool get isInitialized => _instance._isInitialized;
  static bool get activeLogger => _instance._activeLogger;

  String get apiKey {
    if (!_isInitialized) {
      if (kDebugMode) {
        throw Exception(
            'WeAccess has not been initialized. Please call WeAccess.init() before using the package.');
      }
    }
    return _apiKey;
  }
}
