import '../index.dart';

class DatabaseFactory {
  static Database<T> create<T>({DatabaseTypes type = DatabaseTypes.json}) {
    if (type == DatabaseTypes.json) {
      if (T == App) {
        return AppJsonDatabase() as Database<T>;
      }
    }
    if (type == DatabaseTypes.github) {
      if (T == App) {
        return AppGithubDatabase() as Database<T>;
      }
    }

    throw UnsupportedError('$T: Not Supported Database');
  }
}
