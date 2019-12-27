import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:hex/hex.dart';
import 'package:http/http.dart';
import 'package:sparta/core/networking/common/base_transfer_entity.dart';
import 'package:sparta/core/networking/config/api_config.dart';
import 'package:sparta/core/networking/response/error.dart';
import 'package:sparta/core/redux/auth/auth_action.dart';
import 'package:sparta/core/redux/store.dart';

class HttpClient {
  final Client client = Client();
  static HttpClient _inner;

  HttpClient._();

  static HttpClient getInstance() {
    if (_inner == null) {
      _inner = HttpClient._();
    }
    return _inner;
  }

  Future<Map<String, dynamic>> post(String path,
      {data, bool sign = ApiConfig.SIGN}) async {
    String body = jsonEncode(data);
    if (sign) {
      String object = base64Encode(utf8.encode(body));
      var digest = md5.convert(utf8.encode(
          object + SpartaStore.global.state.authState.authInfo.secretKey));
      String sign = HEX.encode(digest.bytes);
      body = jsonEncode(BaseTransferEntity(object, sign));
    }
    var startTime = DateTime.now().millisecondsSinceEpoch;

    try {
      Response response = await client.post(
          Uri.http(ApiConfig.HOST, ApiConfig.CONTEXT_PATH + path),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            ApiConfig.TOKEN_HEADER_KEY:
                SpartaStore.global.state.authState.authInfo.token
          },
          body: body);
      var expendTime = DateTime.now().millisecondsSinceEpoch - startTime;
      debugPrint('''
##### POST $path
##### TIME_TAKEN: ${expendTime}ms
##### STATUS: ${response.statusCode}
##### TOKEN: ${SpartaStore.global.state.authState.authInfo.token}
##### REQUEST_BODY: $body
##### RESPONSE_BODY: ${response.body}
    ''');
      if (response.statusCode != HttpStatus.ok) {
        if (response.statusCode == HttpStatus.unauthorized) {
          SpartaStore.dispatch(InvalidAuthAction());
        }
        throw HttpError.fromJson(jsonDecode(response.body));
      }
      return jsonDecode(response.body);
    } on SocketException catch (e) {
      throw HttpError(e.osError.errorCode, e.osError.message);
    }
  }
}
