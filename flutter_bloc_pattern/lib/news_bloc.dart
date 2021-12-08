import 'dart:async';
import 'dart:convert';

import 'news_info.dart';
import 'package:http/http.dart' as http;

enum NewsAction { Fetch, Delete }

class NewsBloc {
  final _stateStreamController = StreamController<List<Article>>();
  StreamSink<List<Article>> get _newsSink => _stateStreamController.sink;
  Stream<List<Article>> get newsStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<NewsAction>();
  StreamSink<NewsAction> get eventSink => _eventStreamController.sink;
  Stream<NewsAction> get eventStream => _eventStreamController.stream;

  NewsBloc() {
    eventStream.listen((event) async {
      if (event == NewsAction.Fetch) {
        try {
          var news = await getNews();
          if (news != null)
            _newsSink.add(news.articles);
          else
            _newsSink.addError("Something went wrong");
        } on Exception catch (e) {
          _newsSink.addError("Something went wrong");
        }
      }
    });
  }

  Future<NewsModel> getNews() async {
    var client = http.Client();
    var newsModel;

    try {
      var response = await client.get(Uri.parse(
          'http://newsapi.org/v2/everything?domains=wsj.com&apiKey=80a35e4492414e3eb3b4db80304a7089'));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);

        newsModel = NewsModel.fromJson(jsonMap);
      }
    } catch (Exception) {
      return newsModel;
    }

    return newsModel;
  }
}
