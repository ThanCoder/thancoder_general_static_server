import 'dart:io';

import '../thancoder_server.dart';

class ServerFileServices {
  // local
  static String getFilesPath(String name) {
    final dir = '${ThancoderServer.instance.getRootServerDirPath()}/files';
    return '$dir/$name';
  }

  static String getDBFilesPath(String name) {
    final dir = '${ThancoderServer.instance.getRootServerDirPath()}/db_files';
    return '$dir/$name';
  }

  static String getMainDBPath(String name) {
    return '${ThancoderServer.instance.getRootServerDirPath()}/$name.db.json';
  }

  // server
  static String getServerMainUrl(String path) {
    return '${ThancoderServer.instance.getRootServerDirUrl()}/$path';
  }
  static String getServerMainDBUrl(String name) {
    return getServerMainUrl('$name.db.json');
  }

  static String getServerFilesUrl(String name) {
    return '${getServerMainUrl('files')}/$name';
  }

  static String getServerDBFilesUrl(String name) {
    return '${getServerMainUrl('db_files')}/$name';
  }

  static Future<String> createDir(String path) async {
    try {
      final dir = Directory(path);
      if (!await dir.exists()) {
        await dir.create();
      }
    } catch (e) {
      ThancoderServer.showDebugLog(
        '${e.toString()} -> $path',
        tag: 'ServerFileServices:createDir',
      );
    }
    return path;
  }
}
