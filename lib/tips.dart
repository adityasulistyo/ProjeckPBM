import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'read_news.dart';

class NewsSection extends StatefulWidget {
  @override
  _NewsSectionState createState() => _NewsSectionState();
}

class _NewsSectionState extends State<NewsSection> {
  List<NewsItem> newsList = [];

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  Future<void> fetchNews() async {
    String url = 'https://api-berita-indonesia.vercel.app/suara/health/';

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var posts = data['data']['posts'];

      setState(() {
        newsList = (posts as List)
            .map((item) => NewsItem.fromJson(item))
            .toList();
      });
    } else {
      print('Failed to fetch news');
    }
  }

  void openNewsArticle(BuildContext context, NewsItem newsItem) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReadNewsPage(
          title: newsItem.title,
          description: newsItem.description,
          imageUrl: newsItem.thumbnail,
          content: '', // You can fetch the content of the news article here
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: newsList.length,
        itemBuilder: (context, index) {
          return NewsItemCard(
            newsItem: newsList[index],
            onPressed: () {
              openNewsArticle(context, newsList[index]);
            },
          );
        },
      ),
    );
  }
}

class NewsItem {
  final String title;
  final String description;
  final String thumbnail;
  final String link;

  NewsItem({
    required this.title,
    required this.description,
    required this.thumbnail,
    required this.link,
  });

  factory NewsItem.fromJson(Map<String, dynamic> json) {
    return NewsItem(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
      link: json['link'] ?? '',
    );
  }
}

class NewsItemCard extends StatelessWidget {
  final NewsItem newsItem;
  final VoidCallback onPressed;

  NewsItemCard({
    required this.newsItem,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              newsItem.thumbnail,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 8),
            Text(
              newsItem.title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              newsItem.description,
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: onPressed, // Invoke the callback function
              child: Text('Read More'),
            ),
          ],
        ),
      ),
    );
  }
}
