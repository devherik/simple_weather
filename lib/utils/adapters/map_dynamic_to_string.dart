Map<String, dynamic> mapDynamicToString(Map<dynamic, dynamic> input) {
  return input.map((key, value) => MapEntry(key.toString(), value));
}
