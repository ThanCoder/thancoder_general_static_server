import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import '../thancoder_server.dart';

class ServerLocalDatabaseServices {
  // config
  static Future<void> setConfig(
    Map<String, dynamic> map, {
    required String dbPath,
  }) async {
    try {
      final file = File(dbPath);
      final isPrettyDBJson = ThancoderServer.instance.isPrettyDBJson;
      String contents = '';
      if (isPrettyDBJson) {
        contents = JsonEncoder.withIndent(' ').convert(map);
      } else {
        contents = jsonEncode(map);
      }
      await file.writeAsString(contents);
    } catch (e) {
      ThancoderServer.showDebugLog(
        e.toString(),
        tag: 'ServerLocalDatabaseServices:setConfig',
      );
    }
  }

  static Future<Map<String, dynamic>> getConfig(String dbPath) async {
    Map<String, dynamic> map = {};
    try {
      final file = File(dbPath);
      if (!await file.exists()) {
        ThancoderServer.showDebugLog(
          'file not found! -> $dbPath',
          tag: 'ServerLocalDatabaseServices:getConfig',
        );
        return map;
      }
      // found
      final res = jsonDecode(await file.readAsString());
      map = Map<String, dynamic>.from(res);
    } catch (e) {
      ThancoderServer.showDebugLog(
        e.toString(),
        tag: 'ServerLocalDatabaseServices:getConfig',
      );
    }
    return map;
  }

  // list
  static Future<void> setListConfig(
    List<Map<String, dynamic>> mapList, {
    required String dbPath,
  }) async {
    final file = File(dbPath);
    final isPrettyDBJson = ThancoderServer.instance.isPrettyDBJson;
    await Isolate.run(() async {
      try {
        String contents = '';
        if (isPrettyDBJson) {
          contents = JsonEncoder.withIndent(' ').convert(mapList);
        } else {
          contents = jsonEncode(mapList);
        }
        await file.writeAsString(contents);
      } catch (e) {
        ThancoderServer.showDebugLog(
          e.toString(),
          tag: 'ServerLocalDatabaseServices:setListConfig',
        );
      }
    });
  }

  static Future<List<dynamic>> getListConfig(String dbPath) async {
    final file = File(dbPath);

    return Isolate.run<List<dynamic>>(() async {
      List<dynamic> mapList = [];
      try {
        if (!await file.exists()) {
          ThancoderServer.showDebugLog(
            'file not found! -> $dbPath',
            tag: 'ServerLocalDatabaseServices:getListConfig',
          );
          return mapList;
        }
        // found
        final res = jsonDecode(await file.readAsString());
        mapList = List<dynamic>.from(res);
      } catch (e) {
        ThancoderServer.showDebugLog(
          e.toString(),
          tag: 'ServerLocalDatabaseServices:getListConfig',
        );
      }
      return mapList;
    });
  }
}
