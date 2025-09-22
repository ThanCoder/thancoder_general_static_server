import 'package:t_client/t_client.dart';

class ClientServices {
  static final ClientServices instance = ClientServices._();
  ClientServices._();
  factory ClientServices() => instance;

  final TClient _client = TClient();

  TClient get getClient => _client;
}
