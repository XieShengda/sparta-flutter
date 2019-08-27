import 'response.dart';

class Success extends Response {
  Success(int code, String message, this.data) : super(code, message);

  final Map<String, dynamic> data;
}
