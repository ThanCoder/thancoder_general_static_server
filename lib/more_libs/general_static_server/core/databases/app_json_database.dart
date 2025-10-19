import 'package:thancoder_general_static_server/more_libs/general_static_server/services/server_path_services.dart';

import '../index.dart';

class AppJsonDatabase extends JsonDatabase<App> {
  AppJsonDatabase()
    : super(
        root: ServerPathServices.getLocal.getRoot(name: 'app.db.json'),
        storage: FileStorage(root: ServerPathServices.getLocal.getFiles()),
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
