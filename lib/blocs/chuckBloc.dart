import 'dart:async';
import 'package:api_calls_boss/networking/response.dart';
import 'package:api_calls_boss/repository/chuckRepository.dart';
import 'package:api_calls_boss/models/chuckResponse.dart';

class ChuckBloc{
  ChuckRepository _chuckRepository;
  StreamController _chuckDataController;

  StreamSink<Response<ChuckResponse>> get chuckDataSink => _chuckDataController.sink;
  Stream<Response<ChuckResponse>> get chuckDataStream => _chuckDataController.stream;

  ChuckBloc(String category){
    _chuckDataController = StreamController<Response<ChuckResponse>>();
    _chuckRepository = ChuckRepository();
    fetchChuckyJoke(category);
  }

  fetchChuckyJoke(String category) async {
    chuckDataSink.add(Response.loading('Getting A Chucky Joke!'));
    try{
      ChuckResponse chuckJoke = await _chuckRepository.fetchChuckJoke(category);
      chuckDataSink.add(Response.completed(chuckJoke));
    } catch (e) {
      chuckDataSink.add(Response.error(e.toString()));
      print(e);
    }
  }

  dispose(){
    _chuckDataController?.close();
  }
}