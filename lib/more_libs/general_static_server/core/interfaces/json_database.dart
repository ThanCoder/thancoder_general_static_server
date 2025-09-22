import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:than_pkg/t_database/index.dart';

import 'database.dart';

abstract class JsonDatabase<T> extends Database<T> {
  JsonDatabase({required super.root, required super.storage});
  final JsonIO io = JsonIO.instance;

  T from(Map<String, dynamic> map);
  Map<String, dynamic> to(T value);

  @override
  Future<List<T>> getAll({Map<String, dynamic> query = const {}}) async {
    try {
      final source = await io.read(root);
      // print('root: $root');
      // print('source: $source');

      if (source.isEmpty) return [];
      List<dynamic> jsonList = jsonDecode(source);
      // print(jsonList[0]);
      return jsonList.map((map) => from(map)).toList();
    } catch (e) {
      debugPrint('[JsonDatabase:getAll]:${e.toString()}');
    }
    return [];
  }

  @override
  Future<T> add(T value) async {
    final list = await getAll();
    list.add(value);
    await save(list);
    notify(DatabaseChangedListenerTypes.add, null);
    return value;
  }

  Future<void> save(List<T> list) async {
    final jsonList = list.map((e) => to(e)).toList();
    final content = JsonEncoder.withIndent(' ').convert(jsonList);
    await io.write(root, content);
    notify(DatabaseChangedListenerTypes.save, null);
  }
}
