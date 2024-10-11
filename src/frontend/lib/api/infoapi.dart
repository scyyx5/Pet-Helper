import 'dart:convert';
import '../model/info.dart';
import 'package:pethelper/const.dart';
import 'package:http/http.dart' as http;

Future<List<CatInfo>> getCatArticle() async {
  try {
    var data =
        await http.get(Uri.parse(net + "/v1/Article/CatArticles/?format=json"));
    if (data.statusCode == 200) {
      var jsonData = jsonDecode(data.body);
      List<CatInfo> articles = [];
      for (var a in jsonData) {
        CatInfo article = CatInfo(a["id"], a["title"], a["article"],
            a["category"], a["heroid"], a["article_image"]);
        articles.add(article);
      }
      return articles;
    } else {
      return Future.error("SERVER ERROR");
    }
  } catch (e) {
    print(e);
    return Future.error(e);
  }
} //END of function

Future<List<DogInfo>> getDogArticle() async {
  try {
    var data =
        await http.get(Uri.parse(net + "/v1/Article/DogArticles/?format=json"));

    if (data.statusCode == 200) {
      var jsonData = jsonDecode(data.body);
      List<DogInfo> articles = [];
      for (var a in jsonData) {
        DogInfo article = DogInfo(a["id"], a["title"], a["article"],
            a["category"], a["heroid"], a["article_image"]);
        articles.add(article);
      }
      return articles;
    } else {
      return Future.error("SERVER ERROR");
    }
  } catch (e) {
    print(e);
    return Future.error(e);
  }
}
