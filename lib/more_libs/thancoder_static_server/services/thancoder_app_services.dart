import 'dart:convert';

import '../thancoder_server.dart';

class ThancoderAppServices {
  static String get getDBPath {
    return ServerFileServices.getMainDBPath('app');
  }

  static Future<AppRelease?> getNewVersion() async {
    // await Future.delayed(Duration(seconds: 4));

    final current = ThancoderServer.instance.currentPlatform;
    final list = await getOnlineList();
    final index = list.indexWhere((e) => e.packageName == current.packageName);
    if (index == -1) return null;
    final currentApp = list[index];
    final releaseList = await AppReleaseServices.getOnlineList(currentApp.id);
     // filtering platform
    final releasePlatformList = releaseList.where((e)=> e.type == current.type).toList();
    // empty
    if (releasePlatformList.isEmpty) return null;
    //sort
    releasePlatformList.sortVersion();
    // to newest version
    // check version
    if (current.version.compareTo(releasePlatformList.first.version) == -1) {
      return releasePlatformList.first;
    }
    return null;
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
