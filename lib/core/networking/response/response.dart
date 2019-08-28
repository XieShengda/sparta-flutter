import 'error.dart';
import 'success.dart';

abstract class HttpResponse {
  HttpResponse(this.code, this.message);

  final int code;
  final String message;

  bool isError() {
    return this.runtimeType == HttpError;
  }

  bool isSuccess() {
    return this.runtimeType == HttpSuccess;
  }

  @override
  String toString() {
    return 'Response{code: $code, message: $message}';
  }


}
