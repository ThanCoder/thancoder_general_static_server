import 'storage.dart';

mixin DatabaseChangedListener {
  void onDatabaseChanged(DatabaseChangedListenerTypes event, String? key);
}

enum DatabaseChangedListenerTypes { save, delete, add, update }

enum DatabaseTypes { json, github }

abstract class Database<T> {
  final String root;
  final Storage storage;
  Database({required this.root, required this.storage});

  Future<T> add(T value);
  Future<T> update(String id, T value);
  Future<int> delete(String id);
  Future<List<T>> getAll({Map<String, dynamic> query = const {}});

  // listener
  final List<DatabaseChangedListener> _listener = [];
  void addListener(DatabaseChangedListener listener) {
    _listener.add(listener);
  }

  void removeListener(DatabaseChangedListener listener) {
    _listener.remove(listener);
  }

  void clearListener() {
    _listener.clear();
  }

  void notify(DatabaseChangedListenerTypes event, String? key) {
    for (var ev in _listener) {
      ev.onDatabaseChanged(event, key);
    }
  }
}
