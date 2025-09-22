class GeneralServer {
  static final GeneralServer instance = GeneralServer._();
  GeneralServer._();
  factory GeneralServer() => instance;

  late String Function() getServerUrl;
  late String Function() getServerPath;

  Future<void> init({
    required String Function() getServerUrl,
    required String Function() getServerPath,
  }) async {
    this.getServerPath = getServerPath;
    this.getServerUrl = getServerUrl;
  }
}
