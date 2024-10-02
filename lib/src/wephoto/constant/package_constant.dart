import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weaccess/src/wephoto/data/url_data_model.dart';

/// Package constants
const String kPackageName = 'WeAccess';
const String kPackageVersion = '0.0.1';
const String kPackageDescription = 'A new Flutter package.';
const String kPackageAuthor = 'WeAccess Team';
const String kHiveUrlBoxName = 'urlBox';
const String kHiveDirectory = 'weaccess/hive';

Box<URLDataModel> kURLBox = Hive.box<URLDataModel>(kHiveUrlBoxName);
ValueListenable<Box<URLDataModel>> kListenableBox = kURLBox.listenable();
