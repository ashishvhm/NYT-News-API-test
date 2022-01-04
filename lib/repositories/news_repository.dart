import 'package:dio/dio.dart';
import 'package:nyt_api_test/config/base_url_config.dart';
import 'package:nyt_api_test/models/article_model.dart';

class NewsRepository {
  Future<List<ArticleModel>> fetchNews() async {
    try {
     var response = await Dio().get(BaseUrlConfig().baseUrl,
         queryParameters: {'api-key': BaseUrlConfig().keyNewsApi,},
         options: Options(responseType: ResponseType.json));
    var data = response.data;
    List<ArticleModel> _articleModelList = [];
    if (response.statusCode == 200) {
      for (var item in data["results"]) {
        ArticleModel _artcileModel = ArticleModel.fromJson(item);
        _articleModelList.add(_artcileModel);
      }
      return _articleModelList;
    } else {
      return _articleModelList; // empty list
    }
    } catch (e) {
      print(e);
    }
  }

  Future fetchNewsData(String url) async {
    try {
      var response = await Dio().get(BaseUrlConfig().baseUrlForDetails,
          queryParameters: {'fq':'web_url:("'+url+'")','api-key': BaseUrlConfig().keyNewsApi},
          options: Options(responseType: ResponseType.json));
      var data = response.data;
      if (response.statusCode == 200) {
        return data['response']['docs'][0];
      } else {
        return null;
      }
    } catch (e) {
      print(e);
    }
  }

}
