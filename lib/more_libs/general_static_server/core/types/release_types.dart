enum ReleaseTypes {
  android,
  linux;

  static ReleaseTypes getName(String name) {
    if (name == android.name) {
      return android;
    }
    if (name == linux.name) {
      return linux;
    }
    return android;
  }
}
