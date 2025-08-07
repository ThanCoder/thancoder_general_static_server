// ignore_for_file: unused_field

import 'package:flutter/material.dart';

import 'services/index.dart';
import 'types/platform_app.dart';

export 'screens/index.dart';
export 'types/index.dart';
export 'services/index.dart';
export 'components/index.dart';
export 'extensions/index.dart';
export 'views/index.dart';
export 'thancoder_app_notifier_button.dart';

class ThancoderServer {
  static final ThancoderServer instance = ThancoderServer._();
  ThancoderServer._();
  factory ThancoderServer() => instance;

  static bool isShowDebugLog = true;

  late String Function() getRootServerDirPath;
  late String Function() getRootServerDirUrl;
  Widget Function(String text)? getExpandableTextWidget;
  late bool isPrettyDBJson;
  void Function(BuildContext context, String message)? _showMessage;
  late Future<String> Function(String url) getContentFromUrl;
  late PlatformApp currentPlatform;

  Future<void> init({
    required String Function() getRootServerDirPath,
    required String Function() getRootServerDirUrl,
    required Future<String> Function(String url) getContentFromUrl,
    required PlatformApp currentPlatform,
    void Function(BuildContext context, String message)? showMessage,
    Widget Function(String text)? getExpandableTextWidget,
    bool isShowDebugLog = true,
    bool isPrettyDBJson = true,
  }) async {
    this.getRootServerDirPath = getRootServerDirPath;
    this.getRootServerDirUrl = getRootServerDirUrl;
    this.getContentFromUrl = getContentFromUrl;
    isShowDebugLog = isShowDebugLog;
    this.isPrettyDBJson = isPrettyDBJson;
    _showMessage = showMessage;
    this.getExpandableTextWidget = getExpandableTextWidget;
    this.currentPlatform = currentPlatform;
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
