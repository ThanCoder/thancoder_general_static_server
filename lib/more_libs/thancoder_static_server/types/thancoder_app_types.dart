enum ThancoderAppTypes {
  android,
  linux,
  window,
  web;

  static ThancoderAppTypes getTypeFromName(String name) {
    if (name == android.name) {
      return android;
    }
    if (name == linux.name) {
      return linux;
    }
    if (name == web.name) {
      return web;
    }
    if (name == window.name) {
      return window;
    }

    return ThancoderAppTypes.android;
  }
}
