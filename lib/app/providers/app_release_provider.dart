import 'package:flutter/material.dart';
import 'package:thancoder_general_static_server/more_libs/thancoder_static_server/thancoder_server.dart';

class AppReleaseProvider extends ChangeNotifier {
  bool isLoading = false;
  final List<AppRelease> _list = [];
  List<AppRelease> get getList => _list;

  Future<void> initList(String appId) async {
    isLoading = true;
    notifyListeners();
    _list.clear();

    final res = await AppReleaseServices.getList(appId);
    _list.addAll(res);

     // sort
    _list.sortVersion();

    isLoading = false;
    notifyListeners();
  }

  Future<void> add(AppRelease release) async {
    isLoading = true;
    notifyListeners();

    _list.insert(0, release);

    await AppReleaseServices.setList(release.appId,_list);

    // sort
    _list.sortVersion();

    isLoading = false;
    notifyListeners();
  }

  Future<void> update(AppRelease release) async {
    try {
      // isLoading = true;
      // notifyListeners();
      final foundIndex = _list.indexWhere((e) => e.id == release.id);
      if (foundIndex == -1) {
        throw Exception('index not found: [$foundIndex]!');
      }
      _list[foundIndex] = release;

      await AppReleaseServices.setList(release.appId,_list);

      _list.sortVersion();

      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      debugPrint(e.toString());
    }
  }

  Future<void> delete(AppRelease release) async {
    try {
      // isLoading = true;
      // notifyListeners();
      final foundIndex = _list.indexWhere((e) => e.id == release.id);
      if (foundIndex == -1) {
        throw Exception('index not found: [$foundIndex]!');
      }
      _list.removeAt(foundIndex);

      await AppReleaseServices.setList(release.appId,_list);

      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      debugPrint(e.toString());
    }
  }
}
