import '../../general_server.dart';
import '../index.dart';

class AppJsonDatabase extends JsonDatabase<App> {
  AppJsonDatabase()
    : super(
        root: '${GeneralServer.instance.getServerPath()}/app.db.json',
        storage: FileStorage(
          root: '${GeneralServer.instance.getServerPath()}/files',
        ),
      );

  @override
  Future<int> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  App from(Map<String, dynamic> map) {
    final app = App.fromMap(map);
    final coverPath = '${storage.getPath(app.id)}.png';
    return app.copyWith(coverSource: coverPath);
  }

  @override
  Map<String, dynamic> to(App value) {
    return value.toMap();
  }

  @override
  Future<App> update(String id, App value) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
