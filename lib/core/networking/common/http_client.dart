import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:sparta/core/networking/config/api_config.dart';
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

  Future<Map<String, dynamic>> post(String path, {data}) async {
    String body = jsonEncode(data);
    var startTime = DateTime.now().millisecondsSinceEpoch;

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

    return jsonDecode(response.body);
  }
}
