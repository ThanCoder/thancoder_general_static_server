import 'dart:convert';

import 'package:flutter/material.dart';

import '../../services/client_services.dart';
import 'database.dart';

abstract class GithubDatabase<T> extends Database<T> {
  GithubDatabase({required super.root, required super.storage});

  T from(Map<String, dynamic> map);
  // Map<String, dynamic> to(T value);

  @override
  Future<List<T>> getAll({Map<String, dynamic> query = const {}}) async {
    List<T> list = [];
    try {
      final res = await ClientServices.instance.getClient.get(root);

      List<dynamic> jsonList = jsonDecode(res.data.toString());
      list = jsonList.map((map) => from(map)).toList();
    } catch (e) {
      debugPrint('[GithubDatabase:getAll]: ${e.toString()}');
    }
    return list;
  }
}
