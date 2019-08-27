class ApiConfig {
  static const DEFAULT_SUCCESS_CODE = 0;
  static const DEFAULT_ERROR_CODE = -1;
  static const DEFAULT_ERROR_MESSAGE = 'unknown error';
  static const TOKEN_HEADER_KEY = "Authorization";
  static const GUEST_TOKEN = 'Guest';
  static const DEBUG_MSG_ID = '000';
  static const BASE_URL = bool.fromEnvironment("dart.vm.product")
      ? 'http://www.product.com/sparta' //prod
      : 'http://192.168.2.2:80/sparta'; //dev
  static const CONNECT_TIMEOUT = 3000;
  static const RECEIVE_TIMEOUT = 5000;

  static const CONTEXT_PATH = 'sparta';
  static const HOST = bool.fromEnvironment("dart.vm.product")
      ? 'www.product.com' //prod
      : 'www.baidu.com'; //dev;
}
