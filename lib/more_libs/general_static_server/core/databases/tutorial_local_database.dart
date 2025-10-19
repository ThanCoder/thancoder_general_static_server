import 'package:thancoder_general_static_server/more_libs/general_static_server/core/index.dart';
import 'package:thancoder_general_static_server/more_libs/general_static_server/core/models/tutorial.dart';
import 'package:thancoder_general_static_server/more_libs/general_static_server/services/server_path_services.dart';

class TutorialLocalDatabase extends JsonDatabase<Tutorial> {
  TutorialLocalDatabase()
    : super(
        root: ServerPathServices.getLocal.getRoot(name: 'tutorial.db.json'),
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

  @override
  Map<String, dynamic> to(Tutorial value) {
    // TODO: implement to
    throw UnimplementedError();
  }
}
