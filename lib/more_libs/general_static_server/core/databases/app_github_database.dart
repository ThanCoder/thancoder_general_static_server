import '../../general_server.dart';
import '../interfaces/index.dart';
import '../models/app.dart';

class AppGithubDatabase extends GithubDatabase<App> {
  AppGithubDatabase()
    : super(
        root: '${GeneralServer.instance.getServerUrl()}/app.db.json',
        storage: GithubStorage(
          root: '${GeneralServer.instance.getServerUrl()}/files',
        ),
      );

  @override
  Future<App> add(App value) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future<int> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  App from(Map<String, dynamic> map) {
    final app = App.fromMap(map);
    final coverUrl = '${storage.getPath(app.id)}.png';
    return app.copyWith(coverSource: coverUrl);
  }

  @override
  Future<App> update(String id, App value) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
