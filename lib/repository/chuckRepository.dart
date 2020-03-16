import 'package:api_calls_boss/models/chuckResponse.dart';
import 'package:api_calls_boss/networking/apiProvider.dart';
import 'dart:async';

class ChuckRepository{
  ApiProvider _provider = ApiProvider();

  Future<ChuckResponse> fetchChuckJoke(String category) async {
    final response = await _provider.get("jokes/random?category=" + category);
    return ChuckResponse.fromJson(response);
  }
}