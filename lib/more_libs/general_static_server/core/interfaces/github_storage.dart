import 'dart:typed_data';

import 'storage.dart';

class GithubStorage extends Storage {
  GithubStorage({required super.root});

  @override
  Future<bool> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<String>> getList() {
    // TODO: implement getList
    throw UnimplementedError();
  }

  @override
  Future<Uint8List?> read(String id) {
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  Future<bool> write(String id, Uint8List data) {
    // TODO: implement write
    throw UnimplementedError();
  }
}
