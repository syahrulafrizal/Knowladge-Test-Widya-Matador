// ignore_for_file: constant_identifier_names

import 'dart:ui';

class Constants {
  static const String BASE_URL_CDN = 'https://cdn.hsse-rewulu.com/';
  static const String BASE_URL = 'https://api-dev.hsse-rewulu.com/';
  static const String AUTHORIZATION =
      'Basic aHNzZXJld3VsdTpINTUzUjN3dWx1MjAyMQ==';

  static const String METHOD_TYPE_POST = "POST";
  static const String METHOD_TYPE_GET = "GET";

  static const String TOKEN = "TOKEN";

  static const String NO_CONNECTION = 'Koneksi Internet Tidak Tersedia';
  static const String TIMEOUT = 'Timeout Request';
  static const String NODATA = "Tidak ada data yang ditampilkan";
  static const String ERROR_SERVER =
      'Maaf, sistem tidak memberikan respon. Silakan ulangi sekali lagi';

  static const String NOT_FOUND_IMAGE = 'assets/data-not-found.png';
  static const String NOT_CONNECTION_IMAGE = 'assets/no-connection.png';
  static const String ERROR_IMAGE = 'assets/respons-error.png';

  static const Color PRIMARI_COLOR = Color(0xFF754A28);
  static const Color STATUS_BAR_COLOR = Color(0x4D000000);
  static const Color BACKGROUND_COLOR = Color(0xFFFAFAFA);
}
