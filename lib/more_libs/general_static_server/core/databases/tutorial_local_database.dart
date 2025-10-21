import 'package:thancoder_general_static_server/more_libs/general_static_server/core/index.dart';
import 'package:thancoder_general_static_server/more_libs/general_static_server/core/models/tutorial.dart';
import 'package:thancoder_general_static_server/more_libs/general_static_server/services/general_server_path_services.dart';

class TutorialLocalDatabase extends JsonDatabase<Tutorial> {
  TutorialLocalDatabase({super.isUseCacheList})
    : super(
        root: GeneralServerPathServices.getLocal.getRoot(
          name: 'tutorial.db.json',
        ),
      );

  @override
  Tutorial from(Map<String, dynamic> map) {
    return Tutorial.fromMap(map);
  }

  @override
  String getId(Tutorial value) {
    return value.id;
  }

  @override
  Map<String, dynamic> to(Tutorial value) {
    return value.toMap();
  }
}
