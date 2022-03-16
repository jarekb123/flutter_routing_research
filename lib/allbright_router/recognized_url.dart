class RecognizedUrl {
  /// Eg. /path/1
  final String path;

  /// Eg. /path/:id -> /path/1 -> {'id': '1'}
  final Map<String, String> pathParams;

  RecognizedUrl({
    required this.path,
    required this.pathParams,
  });
}
