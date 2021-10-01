import 'dart:convert';

import 'package:shelf/shelf.dart';

class Helpers {}

extension RequestExtension on Request {
  Future<Map<String, dynamic>> parse() async {
    String body = await readAsString();
    if (mimeType!.contains('form-urlencoded')) {
      return Uri.splitQueryString(body);
    }
    return jsonDecode(body) as Map<String, dynamic>;
  }
}
