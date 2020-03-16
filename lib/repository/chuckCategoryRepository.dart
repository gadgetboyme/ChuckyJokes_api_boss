import 'package:api_calls_boss/networking/apiProvider.dart';
import 'package:api_calls_boss/models/chuckCategories.dart';
import 'dart:async';

class ChuckCategoryRepository{
  ApiProvider _provider = ApiProvider();

  Future<ChuckCategories> fetchChuckCategotyData() async {
    final response = await _provider.get("jokes/categories");
    return ChuckCategories.fromJson(response);
  }
}