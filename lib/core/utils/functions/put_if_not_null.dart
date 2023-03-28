extension MapExtension on Map {
  void putIfSome({
    required String key,
    required dynamic value,
  }) {
    if (value != null) {
      this[key] = value;
    }
  }
}
