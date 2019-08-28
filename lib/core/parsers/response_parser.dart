import 'package:sparta/core/networking/config/api_config.dart';
import 'package:sparta/core/networking/response/error.dart';
import 'package:sparta/core/networking/response/response.dart';
import 'package:sparta/core/networking/response/success.dart';

class ResponseParser {
  static HttpResponse parse(Map<String, dynamic> response) {
    if (response == null || response.isEmpty || !response.containsKey('code')) {
      return HttpError(
          ApiConfig.DEFAULT_ERROR_CODE, ApiConfig.DEFAULT_ERROR_MESSAGE);
    }
    if (response['code'] as int == ApiConfig.DEFAULT_SUCCESS_CODE) {
      return HttpSuccess(
          response['code'], response['message'], response['data']);
    } else {
      return HttpError(response['code'], response['message']);
    }
  }
}
