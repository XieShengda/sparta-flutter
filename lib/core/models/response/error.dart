import 'response.dart';

class Error extends Response {
  Error(int code, String message) : super(code, message);
}
