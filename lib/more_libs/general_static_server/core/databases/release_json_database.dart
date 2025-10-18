import '../../general_server.dart';
import '../interfaces/file_storage.dart';
import '../interfaces/json_database.dart';
import '../models/release_app.dart';

class ReleaseJsonDatabase extends JsonDatabase<ReleaseApp> {
  ReleaseJsonDatabase({required super.root})
    : super(
        storage: FileStorage(
          root: '${GeneralServer.instance.getServerPath()}/files',
        ),
      );

  @override
  ReleaseApp from(Map<String, dynamic> map) {
    final res = ReleaseApp.fromMap(map);
    // final path =
    return res;
  }

  @override
  Map<String, dynamic> to(ReleaseApp value) {
    return value.toMap();
  }

  @override
  String getId(ReleaseApp value) {
    return value.id;
  }
}
