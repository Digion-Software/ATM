class APIResponse {
  final Map<String, String> header;
  final bool isSuccess;
  final int statusCode;
  final String data;

  APIResponse({required this.header, required this.isSuccess, required this.statusCode, required this.data});
}
