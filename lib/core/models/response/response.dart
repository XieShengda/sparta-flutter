import 'error.dart';
import 'success.dart';

abstract class Response {
  Response(this.code, this.message);

  final int code;
  final String message;

  bool isError() {
    return this.runtimeType == Error;
  }

  bool isSuccess() {
    return this.runtimeType == Success;
  }
}
