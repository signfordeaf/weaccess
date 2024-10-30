// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'url_data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class URLDataModelAdapter extends TypeAdapter<URLDataModel> {
  @override
  final int typeId = 0;

  @override
  URLDataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return URLDataModel(
      imageUrl: fields[0] as String,
      shortImageCaption: fields[1] as String?,
      longImageCaption: fields[2] as String?,
      imageType: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, URLDataModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.imageUrl)
      ..writeByte(1)
      ..write(obj.shortImageCaption)
      ..writeByte(2)
      ..write(obj.longImageCaption)
      ..writeByte(3)
      ..write(obj.imageType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is URLDataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
