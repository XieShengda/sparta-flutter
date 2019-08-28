import 'response.dart';

class HttpError extends HttpResponse {
  HttpError(int code, String message) : super(code, message);

  factory HttpError.fromJson(Map<String, dynamic> json) =>
      HttpError(json['code'], json['message']);

  @override
  String toString() {
    return 'Error{code: $code, message: $message}';
  }
}
