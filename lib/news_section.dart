import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewsSection extends StatefulWidget {
  @override
  _NewsSectionState createState() => _NewsSectionState();
}

class _NewsSectionState extends State<NewsSection> {
  List<dynamic> newsList = [];

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  Future<void> fetchNews() async {
    String url = 'https://api-berita-indonesia.vercel.app/suara/health/';

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      var data = jsonData['data'];
      setState(() {
        newsList = data['posts'];
      });
    } else {
      print('Failed to fetch news');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: newsList.length,
          itemBuilder: (BuildContext context, int index) {
            var news = newsList[index];
            return ListTile(
              leading: Image.network(news['thumbnail']),
              title: Text(
                news['title'],
                style: TextStyle(fontFamily: 'Exo2'),
              ),
              subtitle: Text(
                news['description'],
                style: TextStyle(fontFamily: 'Exo2'),
              ),
            );
          },
        ),
      ),
    );
  }
}
