import 'dart:convert';
import 'package:http/http.dart' as http;

const apiKey = '50c89dfbaf8645269b0889243d230213';

Future<News> fetchNews(String country) async {
  final response = await http.get(Uri.parse(
      'https://newsapi.org/v2/top-headlines?country=$country&apiKey=$apiKey'));
  if (response.statusCode == 200) {
    return News.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load news $country ${response.statusCode}');
  }
}

class News {
  late String status;
  late int totalResults;
  late List<Article> articles;

  News(
      {required this.status,
      required this.totalResults,
      required this.articles});

  News.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalResults = json['totalResults'];
    if (json['articles'] != null) {
      articles = [];
      json['articles'].forEach((v) {
        articles.add(Article.fromJson(v));
      });
    }
  }
}

class Article {
  Source? source;
  late String? author;
  late String? title;
  late String? description;
  late String? url;
  late String? urlToImage;
  late String? publishedAt;
  late String? content;

  Article(
      {required this.author,
      this.source,
      required this.title,
      required this.description,
      required this.url,
      required this.urlToImage,
      required this.publishedAt,
      required this.content});

  Article.fromJson(Map<String, dynamic> json) {
    source = json['source'] != null ? Source.fromJson(json['source']) : null;
    author = json['author'];
    title = json['title'];
    description = json['description'];
    url = json['url'];
    urlToImage = json['urlToImage'];
    publishedAt = json['publishedAt'];
    content = json['content'];
  }
}

class Source {
  String? id;
  String? name;

  Source({required this.id, required this.name});

  Source.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}
