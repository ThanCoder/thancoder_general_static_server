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
  String getId(App value) {
    return value.id;
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
}
