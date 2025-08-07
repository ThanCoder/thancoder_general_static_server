import 'dart:convert';

import '../thancoder_server.dart';

class AppReleaseServices {
  static String getDBPath(String appId) {
    return ServerFileServices.getDBFilesPath('$appId.app.release.db.json');
  }

  static Future<List<AppRelease>> getOnlineList(String appId) async {
    try {
      final url = ServerFileServices.getServerDBFilesUrl(
        '$appId.app.release.db.json',
      );
      final source = await ThancoderServer.instance.getContentFromUrl(url);
      List<dynamic> resList = jsonDecode(source);
      return resList.map((e) => AppRelease.fromMap(e)).toList();
    } catch (e) {
      ThancoderServer.showDebugLog(
        e.toString(),
        tag: 'AppReleaseServices:getOnlineList',
      );
      return [];
    }
  }

  static Future<void> setList(String appId, List<AppRelease> list) async {
    await ServerLocalDatabaseServices.setListConfig(
      list.map((e) => e.toMap()).toList(),
      dbPath: getDBPath(appId),
    );
  }

  static Future<List<AppRelease>> getList(String appId) async {
    final resList = await ServerLocalDatabaseServices.getListConfig(
      getDBPath(appId),
    );
    return resList.map((e) => AppRelease.fromMap(e)).toList();
  }

  // cover
  static Future<List<String>> getCoverList(String appId) async {
    // final resList = await ServerLocalDatabaseServices.getListConfig(
    //   getDBPath(appId),
    // );
    return [
      'https://github.com/user-attachments/assets/c79ef5ef-bbdc-4833-b895-c81b00c7602a',
      'https://github.com/user-attachments/assets/1c58fdc2-1c80-4ba5-82a2-5e16beae76d6',
      'https://github.com/user-attachments/assets/bfaf4a95-937f-4462-b65c-6d40f7335bee',
      'https://github.com/user-attachments/assets/8b696688-6eae-4f83-a065-027b54072ab2',
    ];
  }
  static Future<List<String>> getOnlineCoverList(String appId) async {
    return [
      'https://github.com/user-attachments/assets/c79ef5ef-bbdc-4833-b895-c81b00c7602a',
      'https://github.com/user-attachments/assets/1c58fdc2-1c80-4ba5-82a2-5e16beae76d6',
      'https://github.com/user-attachments/assets/bfaf4a95-937f-4462-b65c-6d40f7335bee',
      'https://github.com/user-attachments/assets/8b696688-6eae-4f83-a065-027b54072ab2',
    ];
  }
}
