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
  App from(Map<String, dynamic> map) {
    final app = App.fromMap(map);
    final coverUrl = '${storage.getPath(app.id)}.png';
    return app.copyWith(coverSource: coverUrl);
  }

  @override
  String getId(App value) {
    return value.id;
  }
}
