
import 'package:sparta/core/networking/config/api_config.dart';

import '../models/response/error.dart';
import '../models/response/response.dart';
import '../models/response/success.dart';

class ResponseParser {
  static Response parse(Map<String, dynamic> response) {
    if (response == null || response.isEmpty || !response.containsKey('code')) {
      return Error(
          ApiConfig.DEFAULT_ERROR_CODE, ApiConfig.DEFAULT_ERROR_MESSAGE);
    }
    if (response['code'] as int == ApiConfig.DEFAULT_SUCCESS_CODE) {
      return Success(response['code'], response['message'], response['data']);
    } else {
      return Error(response['code'], response['message']);
    }
  }
}
