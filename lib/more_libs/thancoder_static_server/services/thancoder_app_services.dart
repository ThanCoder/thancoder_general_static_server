import 'dart:isolate';

import '../thancoder_server.dart';

class ThancoderAppServices {
  static String get getDBPath {
    return ServerFileServices.getMainDBPath('app');
  }

  Future<void> setList(List<ThancoderApp> list) async {
    await Isolate.run(() async {
      try {
        await ServerLocalDatabaseServices.setListConfig(
          list.map((e) => e.toMap()).toList(),
          dbPath: getDBPath,
        );
      } catch (e) {
        ThancoderServer.instance.showDebugLog(
          e.toString(),
          tag: 'ThancoderAppServices:setList',
        );
      }
    });
  }

  Future<List<ThancoderApp>> getList() async {
    return await Isolate.run<List<ThancoderApp>>(() async {
      List<ThancoderApp> list = [];
      try {
        final resList = await ServerLocalDatabaseServices.getListConfig(
          getDBPath,
        );
        list = resList.map((e) => ThancoderApp.fromMap(e)).toList();
      } catch (e) {
        ThancoderServer.instance.showDebugLog(
          e.toString(),
          tag: 'ThancoderAppServices:getList',
        );
      }
      return list;
    });
  }
}
