import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ReadNewsPage extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  final String content;

  ReadNewsPage({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.content,
  });

  void shareNewsLink() async {
    String url = ''; // Isi dengan URL berita yang ingin dibagikan
    if (await canLaunchUrl(url as Uri)) {
      await launchUrl(url as Uri);
    } else {
      print('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Read News'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                imageUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 16),
              Text(
                title,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                description,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),
              Text(
                content,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              // SizedBox(height: 16),
              // ElevatedButton(

              //   onPressed: shareNewsLink,
              //   child: Text('Share Link'),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
