import 'dart:io';

class Server {
  static String get URL {
    if (Platform.isAndroid) {
      return 'http://192.168.100.118:8000';
    } else {
      return 'http://localhost:8000';
    }
  }
}
