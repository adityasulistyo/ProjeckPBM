import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
    String apiKey = 'a5963a5fd95648f290114b1dfdd512ea';
    String url =
        'https://newsapi.org/v2/everything?q=health%20tips%20for%20fasting&apiKey=$apiKey';

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      setState(() {
        newsList = (data['articles'] as List)
            .map((item) => NewsItem.fromJson(item))
            .toList();
      });
    } else {
      print('Failed to fetch news');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: newsList.length,
        itemBuilder: (context, index) {
          return NewsItemCard(newsItem: newsList[index]);
        },
      ),
    );
  }
}

class NewsItem {
  final String title;
  final String imageUrl;

  NewsItem({
    required this.title,
    required this.imageUrl,
  });

  factory NewsItem.fromJson(Map<String, dynamic> json) {
    return NewsItem(
      title: json['title'],
      imageUrl: json['urlToImage'],
    );
  }
}

class NewsItemCard extends StatelessWidget {
  final NewsItem newsItem;

  NewsItemCard({required this.newsItem});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              newsItem.imageUrl,
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
          ],
        ),
      ),
    );
  }
}
