
Future<Map<String, String>> rawDataHeader([String? token]) async {
  return {
    'Content-Type': 'application/json',
  };
}

Future<Map<String, String>> formDataHeader([String? token]) async {
  return {
    'Accept': 'application/json',
  };
}
