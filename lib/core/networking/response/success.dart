import 'response.dart';

class HttpSuccess extends HttpResponse {
  HttpSuccess(int code, String message, this.data) : super(code, message);

  final Map<String, dynamic> data;
}
