import 'package:thancoder_general_static_server/more_libs/general_static_server/core/interfaces/file_storage.dart';
import 'package:thancoder_general_static_server/more_libs/general_static_server/core/interfaces/api_database.dart';
import 'package:thancoder_general_static_server/more_libs/general_static_server/core/models/tutorial.dart';
import 'package:thancoder_general_static_server/more_libs/general_static_server/services/server_path_services.dart';

class TutorialApiDatabase extends ApiDatabase<Tutorial> {
  TutorialApiDatabase()
    : super(
        root: ServerPathServices.getApi.getRoot(name: 'tutorial.db.json'),
        storage: FileStorage(root: ''),
      );

  @override
  Tutorial from(Map<String, dynamic> map) {
    // TODO: implement from
    throw UnimplementedError();
  }

  @override
  String getId(Tutorial value) {
    // TODO: implement getId
    throw UnimplementedError();
  }
}
