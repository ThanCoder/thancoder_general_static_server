import 'dart:convert';
import 'dart:io';

import '../thancoder_server.dart';

class ServerLocalDatabaseServices {
  static Future<void> setConfig(
    Map<String, dynamic> map, {
    required String dbPath,
    bool isPretty = true,
  }) async {
    try {
      final file = File(dbPath);
       String contents = '';
      if (isPretty) {
        contents = JsonEncoder.withIndent(' ').convert(map);
      } else {
        contents = jsonEncode(map);
      }
      await file.writeAsString(contents);
    } catch (e) {
      ThancoderServer.instance.showDebugLog(
        e.toString(),
        tag: 'ServerDatabaseServices:setConfig',
      );
    }
  }

  static Future<void> setListConfig(
    List<Map<String, dynamic>> mapList, {
    required String dbPath,
    bool isPretty = true,
  }) async {
    try {
      final file = File(dbPath);
      String contents = '';
      if (isPretty) {
        contents = JsonEncoder.withIndent(' ').convert(mapList);
      } else {
        contents = jsonEncode(mapList);
      }
      await file.writeAsString(contents);
    } catch (e) {
      ThancoderServer.instance.showDebugLog(
        e.toString(),
        tag: 'ServerDatabaseServices:setListConfig',
      );
    }
  }

  // get
  static Future<Map<String, dynamic>> getConfig(
    String dbPath, {
    bool isPretty = true,
  }) async {
    Map<String, dynamic> map = {};
    try {
      final file = File(dbPath);
      if (!await file.exists()) {
        ThancoderServer.instance.showDebugLog(
          'file not found! -> $dbPath',
          tag: 'ServerDatabaseServices:getConfig',
        );
        return map;
      }
      // found
      final res = jsonDecode(await file.readAsString());
      map = Map<String, dynamic>.from(res);
    } catch (e) {
      ThancoderServer.instance.showDebugLog(
        e.toString(),
        tag: 'ServerDatabaseServices:getConfig',
      );
    }
    return map;
  }

  static Future<List<dynamic>> getListConfig(
    String dbPath, {
    bool isPretty = true,
  }) async {
    List<dynamic> mapList = [];
    try {
      final file = File(dbPath);
      if (!await file.exists()) {
        ThancoderServer.instance.showDebugLog(
          'file not found! -> $dbPath',
          tag: 'ServerDatabaseServices:getListConfig',
        );
        return mapList;
      }
      // found
      final res = jsonDecode(await file.readAsString());
      mapList = List<dynamic>.from(res);
    } catch (e) {
      ThancoderServer.instance.showDebugLog(
        e.toString(),
        tag: 'ServerDatabaseServices:getListConfig',
      );
    }
    return mapList;
  }
}
