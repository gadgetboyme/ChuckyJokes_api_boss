import 'dart:async';
import 'package:api_calls_boss/networking/response.dart';
import 'package:api_calls_boss/repository/chuckCategoryRepository.dart';
import 'package:api_calls_boss/models/chuckCategories.dart';

class ChuckCategoryBloc{

  ChuckCategoryRepository _chuckCategoryRepository;
  StreamController _chuckListController;

  StreamSink<Response<ChuckCategories>> get chuckListSink => _chuckListController.sink;
  Stream<Response<ChuckCategories>> get chuckListStream => _chuckListController.stream;

  ChuckCategoryBloc() {
    _chuckListController = StreamController<Response<ChuckCategories>>();
    _chuckCategoryRepository = ChuckCategoryRepository();
    fetchCategories();
  }

  fetchCategories() async {
    chuckListSink.add(Response.loading('Getting Chuck Categories.'));
    try{
      ChuckCategories chuckCats = await _chuckCategoryRepository.fetchChuckCategotyData();
      chuckListSink.add(Response.completed(chuckCats));
    } catch (e) {
      chuckListSink.add(Response.error(e.toString()));
      print(e);
    }
  }

  dispose(){
    _chuckListController?.close();
  }

}