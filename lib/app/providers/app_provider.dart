import 'package:flutter/material.dart';
import 'package:thancoder_general_static_server/more_libs/thancoder_static_server/thancoder_server.dart';

class AppProvider extends ChangeNotifier {
  bool isLoading = false;
  final List<ThancoderApp> _list = [];
  List<ThancoderApp> get getList => _list;

  Future<void> initList() async {
    isLoading = true;
    notifyListeners();
    _list.clear();

    final res = await ThancoderAppServices.getList();
    _list.addAll(res);

    isLoading = false;
    notifyListeners();
  }

  Future<void> add(ThancoderApp app) async {
    isLoading = true;
    notifyListeners();

    _list.insert(0, app);

    await ThancoderAppServices.setList(_list);

    isLoading = false;
    notifyListeners();
  }

  Future<void> update(ThancoderApp app) async {
    try {
      // isLoading = true;
      // notifyListeners();

      final foundIndex = _list.indexWhere((e) => e.id == app.id);
      if (foundIndex == -1) {
        throw Exception('index not found: [$foundIndex]!');
      }

      _list[foundIndex] = app;

      await ThancoderAppServices.setList(_list);

      isLoading = false;
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> delete(ThancoderApp app) async {
    try {
      // isLoading = true;
      // notifyListeners();

      final foundIndex = _list.indexWhere((e) => e.id == app.id);
      if (foundIndex == -1) {
        throw Exception('index not found: [$foundIndex]!');
      }

      _list.removeAt(foundIndex);
      //delete
      await app.deleteAll();

      await ThancoderAppServices.setList(_list);

      isLoading = false;
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
