import '../thancoder_server.dart';

class AppReleaseServices {
  static String getDBPath(String appId) {
    return ServerFileServices.getDBFilesPath('$appId.app.release.db.json');
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
}
