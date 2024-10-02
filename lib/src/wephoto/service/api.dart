import 'package:dio/dio.dart';
import 'package:weaccess/src/weaccess.dart';

class ApiServices {
  CancelToken _cancelToken = CancelToken();
  final WeAccess _weAccess = WeAccess();

  var dio = Dio(
    BaseOptions(
      baseUrl: 'http://68.154.90.84:8081/api/',
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );

  Future<String> getImageCaption({
    required String imagePath,
    String dest = 'en',
  }) async {
    var data = {
      'api_key': _weAccess.apiKey,
      'image_url': imagePath,
      'dest': dest,
      'description_type': 'short'
    };

    try {
      var response = await dio.request(
        'describe-image',
        options: Options(
          method: 'GET',
        ),
        queryParameters: data,
        cancelToken: _cancelToken,
      );

      switch (response.statusCode) {
        case 200:
          final outputList = response.data['output'] as List?;
          if (outputList != null) {
            return outputList[0] ?? 'No Image Caption available';
          }
          return 'No Image Caption available';
        case 400:
          return '';
        case 401:
          return '';
        case 403:
          return '';
        case 404:
          return '';
        case 500:
          return '';
        default:
          return '';
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
    var data = {
      'api_key': _weAccess.apiKey,
      'image_url': imagePath,
      'dest': dest,
      'description_type': descriptionType
    };

    try {
      var response = await dio.request(
        'describe-image',
        options: Options(
          method: 'GET',
        ),
        queryParameters: data,
        cancelToken: _cancelToken,
      );

      switch (response.statusCode) {
        case 200:
          final outputList = response.data['output'] as List?;
          if (outputList != null) {
            return outputList[0] ?? 'No Image Caption available';
          }
          return 'No Image Caption available';
        case 400:
          return '';
        case 401:
          return '';
        case 403:
          return '';
        case 404:
          return '';
        case 500:
          return '';
        default:
          return '';
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
