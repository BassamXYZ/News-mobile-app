import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:news_app/api.dart';

class ProductCard extends StatelessWidget {
  final Article article;
  const ProductCard({required this.article});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            /*(article.urlToImage != null
                ? Image.network('${Uri.parse('${article.urlToImage}')}')
                : const Text('there is no image'))*/
            if (article.urlToImage != null)
              Image.network('${article.urlToImage}'),
            Text('${article.title}'),
            Text(
              '${article.description}',
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            Text('${article.author}'),
            Text('${article.publishedAt}'),
            Text('${article.source!.name}'),
            ElevatedButton(
              onPressed: _launchURL('${article.url}'),
              child: const Text('Read Article'),
            ),
          ],
        ),
      ),
    );
  }
}

_launchURL(String url) async {
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  } else {
    throw 'Could not launch $url';
  }
}
