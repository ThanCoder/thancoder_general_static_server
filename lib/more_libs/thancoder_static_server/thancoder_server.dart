// ignore_for_file: unused_field

import 'package:flutter/material.dart';

export 'screens/index.dart';
export 'types/index.dart';
export 'services/index.dart';

class ThancoderServer {
  static final ThancoderServer instance = ThancoderServer._();
  ThancoderServer._();
  factory ThancoderServer() => instance;

  late String Function() getRootServerDirPath;
  late String Function() getRootServerDirUrl;
  late bool isShowDebugLog;

  Future<void> init({
    required String Function() getRootServerDirPath,
    required String Function() getRootServerDirUrl,
    bool isShowDebugLog = true,
  }) async {
    this.getRootServerDirPath = getRootServerDirPath;
    this.getRootServerDirUrl = getRootServerDirUrl;
    this.isShowDebugLog = isShowDebugLog;
  }

  // log
  void showDebugLog(String msg, {String? tag}) {
    if (!isShowDebugLog) return;
    if (tag != null) {
      debugPrint('[$tag]: $msg');
      return;
    }
    debugPrint(msg);
  }

  static String get getInitErroLogString {
    return '''
main.dart file

await ThancoderServer.instance.init(getRootServerDirPath: () => rootPath);''';
  }
}
