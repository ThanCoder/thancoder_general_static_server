import 'package:thancoder_general_static_server/more_libs/general_static_server/services/server_path_services.dart';

import '../interfaces/index.dart';
import '../models/app.dart';

class AppApiDatabase extends ApiDatabase<App> {
  AppApiDatabase()
    : super(
        root: ServerPathServices.getApi.getRoot(name: 'app.db.json'),
        storage: FileStorage(root: ServerPathServices.getApi.getFiles()),
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
