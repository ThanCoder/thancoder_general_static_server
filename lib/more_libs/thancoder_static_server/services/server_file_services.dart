import 'dart:io';

import '../thancoder_server.dart';

class ServerFileServices {
  static String getMainDBPath(String name) {
    return '${ThancoderServer.instance.getRootServerDirPath}/$name.db.json';
  }

  static Future<String> createDir(String path) async {
    final dir = Directory(path);
    if (!await dir.exists()) {
      await dir.create();
    }
    return path;
  }
}
