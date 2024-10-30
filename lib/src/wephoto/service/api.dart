import 'dart:io';

import 'package:dio/dio.dart';
import 'package:tuple/tuple.dart';
import 'package:weaccess/src/weaccess.dart';

class ApiServices {
  CancelToken _cancelToken = CancelToken();
  final WeAccess _weAccess = WeAccess();

  var dio = Dio(
    BaseOptions(
      baseUrl: 'https://pl.weaccess.ai/mobile/api/',
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );

  Future<String> getImageCaption({
    required String imagePath,
    String dest = 'en',
  }) async {
    var data = FormData.fromMap({
      'api_key': _weAccess.apiKey,
      'image_url': imagePath,
      'lang': dest,
      'create_types': ['alt']
    });

    try {
      var response = await dio.request(
        'wephoto-create/',
        options: Options(
          method: 'POST',
        ),
        data: data,
        cancelToken: _cancelToken,
      );
      switch (response.statusCode) {
        case 200 || 201 || 202 || 203 || 204:
          final outputList = response.data['image_alt_text'] as List?;
          if (outputList != null) {
            return outputList[0] ?? 'No Image Caption available';
          }
          return 'No Image Caption available';
        case 400:
          return 'No Image Caption available';
        case 401:
          return 'No Image Caption available';
        case 403:
          return 'No Image Caption available';
        case 404:
          return 'No Image Caption available';
        case 500:
          return 'No Image Caption available';
        default:
          return 'No Image Caption available';
      }
    } catch (e) {
      if (e is DioException) {
        print('DioError: ${e.response?.statusCode}');
        // Hata durumunda özel işlem
        if (e.response?.statusCode == 500) {
          print('Sunucu tarafında bir hata oluştu.');
        }
      }
      return 'Server error, The server encountered an internal error and was unable to complete the request. $e';
    }
  }

  Future<String> getLongImageCaption({
    required String imagePath,
    String dest = 'en',
    String descriptionType = 'long',
  }) async {
    var data = FormData.fromMap({
      'api_key': _weAccess.apiKey,
      'image_url': imagePath,
      'lang': dest,
      'create_types': ['desc']
    });

    try {
      var response = await dio.request(
        'wephoto-create/',
        options: Options(
          method: 'POST',
        ),
        data: data,
        cancelToken: _cancelToken,
      );

      switch (response.statusCode) {
        case 200 || 201 || 202 || 203 || 204:
          final outputList = response.data['image_desc'] as List?;
          if (outputList != null) {
            return outputList[0] ?? 'No Image Caption available';
          }
          return 'No Image Caption available';
        case 400:
          return 'No Image Caption available';
        case 401:
          return 'No Image Caption available';
        case 403:
          return 'No Image Caption available';
        case 404:
          return 'No Image Caption available';
        case 500:
          return 'No Image Caption available';
        default:
          return 'No Image Caption available';
      }
    } catch (e) {
      throw 'Server error: The server encountered an internal error and was unable to complete the request.';
    }
  }

  Future<Tuple2<String, String>> getImageDescriptionFile({
    required File image,
    String dest = 'en',
  }) async {
    var data = FormData.fromMap({
      'api_key': _weAccess.apiKey,
      'lang': dest,
      'create_types': '["alt", "desc"]',
    });

    data.files.add(
      MapEntry(
        'file',
        MultipartFile.fromFileSync(
          image.path,
        ),
      ),
    );
    try {
      var response = await dio.request(
        'wephoto-create/',
        options: Options(
          method: 'POST',
        ),
        data: data,
        cancelToken: _cancelToken,
      );
      switch (response.statusCode) {
        case 200 || 201 || 202 || 203 || 204:
          final altOutputList = response.data['image_alt_text'] as List?;
          final descOutputList = response.data['image_desc'] as List?;
          return Tuple2(altOutputList?[0] ?? 'No Image Caption available',
              descOutputList?[0] ?? 'No Image Caption available');
        case 400:
          return const Tuple2(
              'No Image Caption available', 'No Image Caption available');
        case 401:
          return const Tuple2(
              'No Image Caption available', 'No Image Caption available');
        case 403:
          return const Tuple2(
              'No Image Caption available', 'No Image Caption available');
        case 404:
          return const Tuple2(
              'No Image Caption available', 'No Image Caption available');
        case 500:
          return const Tuple2(
              'No Image Caption available', 'No Image Caption available');
        default:
          return const Tuple2(
              'No Image Caption available', 'No Image Caption available');
      }
    } catch (e) {
      throw 'Server error: The server encountered an internal error and was unable to complete the request.';
    }
  }

  void dispose() {
    _cancelToken.cancel();
    _cancelToken = CancelToken();
  }
}
