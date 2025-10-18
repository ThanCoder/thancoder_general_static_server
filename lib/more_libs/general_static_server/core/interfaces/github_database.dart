import 'dart:convert';

import 'package:flutter/material.dart';

import '../../services/client_services.dart';
import 'database.dart';

abstract class GithubDatabase<T> extends Database<T> {
  GithubDatabase({required super.root, required super.storage});

  T from(Map<String, dynamic> map);
  String getId(T value);
  final List<T> _list = [];

  @override
  Future<List<T>> getAll({Map<String, dynamic>? query}) async {
    if (_list.isNotEmpty) return _list;

    try {
      final res = await ClientServices.instance.getClient.get(root);

      List<dynamic> jsonList = jsonDecode(res.data.toString());
      _list.clear();
      final resList = jsonList.map((map) => from(map)).toList();
      _list.addAll(resList);
    } catch (e) {
      debugPrint('[GithubDatabase:getAll]: ${e.toString()}');
    }
    return _list;
  }

  @override
  Future<T?> getById(String id) async {
    final list = await getAll();
    final index = list.indexWhere((e) => getId(e) == id);
    if (index == -1) return null;
    return list[index];
  }

  @override
  Future<T> add(T value) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future<bool> update(String id, T value) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<int> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }
}
