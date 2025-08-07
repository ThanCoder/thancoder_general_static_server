// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:thancoder_general_static_server/more_libs/thancoder_static_server/services/server_file_services.dart';

export 'screens/index.dart';
export 'types/index.dart';
export 'services/index.dart';
export 'components/index.dart';
export 'extensions/index.dart';

class ThancoderServer {
  static final ThancoderServer instance = ThancoderServer._();
  ThancoderServer._();
  factory ThancoderServer() => instance;

  late String Function() getRootServerDirPath;
  late String Function() getRootServerDirUrl;
  static bool isShowDebugLog = true;
  late bool isPrettyDBJson;
  void Function(BuildContext context, String message)? _showMessage;

  Future<void> init({
    required String Function() getRootServerDirPath,
    required String Function() getRootServerDirUrl,
    void Function(BuildContext context, String message)? showMessage,
    bool isShowDebugLog = true,
    bool isPrettyDBJson = true,
  }) async {
    this.getRootServerDirPath = getRootServerDirPath;
    this.getRootServerDirUrl = getRootServerDirUrl;
    isShowDebugLog = isShowDebugLog;
    this.isPrettyDBJson = isPrettyDBJson;
    _showMessage = showMessage;
    // init path
    await ServerFileServices.createDir('${getRootServerDirPath()}/files');
    await ServerFileServices.createDir('${getRootServerDirPath()}/db_files');
  }

  void showMessage(BuildContext context, String message) {
    if (_showMessage == null) return;
    _showMessage!(context, message);
  }

  // static
  // log
  static void showDebugLog(String message, {String? tag}) {
    if (!isShowDebugLog) return;
    if (tag != null) {
      debugPrint('[$tag]: $message');
      return;
    }
    debugPrint(message);
  }

  static String get getInitErroLogString {
    return '''
main.dart file

await ThancoderServer.instance.init(getRootServerDirPath: () => rootPath);''';
  }
}
