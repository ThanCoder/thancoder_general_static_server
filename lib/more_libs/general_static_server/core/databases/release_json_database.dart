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
  Future<int> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

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
  Future<ReleaseApp> update(String id, ReleaseApp value) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
