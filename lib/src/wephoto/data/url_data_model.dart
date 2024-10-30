import 'package:hive/hive.dart';

part 'url_data_model.g.dart';

@HiveType(typeId: 0)
class URLDataModel extends HiveObject {
  @HiveField(0)
  String imageUrl;
  @HiveField(1)
  String? shortImageCaption;
  @HiveField(2)
  String? longImageCaption;
  @HiveField(3)
  String? imageType;

  URLDataModel({
    required this.imageUrl,
    this.shortImageCaption,
    this.longImageCaption,
    this.imageType,
  });

  copyWith({
    String? imageUrl,
    String? shortImageCaption,
    String? longImageCaption,
    String? imageType,
  }) {
    return URLDataModel(
      imageUrl: imageUrl ?? this.imageUrl,
      shortImageCaption: shortImageCaption ?? this.shortImageCaption,
      longImageCaption: longImageCaption ?? this.longImageCaption,
      imageType: imageType ?? this.imageType,
    );
  }
}
