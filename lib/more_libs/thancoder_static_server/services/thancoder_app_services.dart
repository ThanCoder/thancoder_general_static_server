import '../thancoder_server.dart';

class ThancoderAppServices {
  static String get getDBPath {
    return ServerFileServices.getMainDBPath('app');
  }

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
