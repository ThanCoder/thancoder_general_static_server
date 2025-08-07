import 'dart:convert';

import '../thancoder_server.dart';

class ThancoderAppServices {
  static String get getDBPath {
    return ServerFileServices.getMainDBPath('app');
  }

  // online
  static Future<List<ThancoderApp>> getOnlineList() async {
    try {
      final url = ServerFileServices.getServerMainDBUrl('app');
      final res = await ThancoderServer.instance.getContentFromUrl(url);
      List<dynamic> resList = jsonDecode(res);
      return resList.map((e) => ThancoderApp.fromMap(e)).toList();
    } catch (e) {
      ThancoderServer.showDebugLog(
        e.toString(),
        tag: 'ThancoderAppServices:getOnlineList',
      );
    return [];
    }
  }

  // local

  static Future<void> setList(List<ThancoderApp> list) async {
    await ServerLocalDatabaseServices.setListConfig(
      list.map((e) => e.toMap()).toList(),
      dbPath: getDBPath,
    );
  }

  static Future<List<ThancoderApp>> getList() async {
    final resList = await ServerLocalDatabaseServices.getListConfig(getDBPath);
    return resList.map((e) => ThancoderApp.fromMap(e)).toList();
  }
}
