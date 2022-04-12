import 'dart:convert';

import 'package:bloc_weeknd/feature/model/cats_http.dart';
import 'package:http/http.dart' as http;

abstract class CatsGetsClass {
  Future<List<CatsModel>> getCats();
}

class CatsService implements CatsGetsClass {
  final baseUrl = "https://hwasampleapi.firebaseio.com/http.json";
  @override
  Future<List<CatsModel>> getCats() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final jsonbody = jsonDecode(response.body) as List;
      return jsonbody.map((e) => CatsModel.fromJson(e)).toList();
    } else {
      throw NetworError(response.statusCode.toString(), response.body);
    }
  }
}

class NetworError implements Exception {
  final String statusCode;
  final String messsage;

  NetworError(this.statusCode, this.messsage);
}
