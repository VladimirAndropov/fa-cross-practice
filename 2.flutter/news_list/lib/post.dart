import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

    Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      throw 'Unable to open link: $url';
    }
  }
  
class Post extends StatelessWidget {
  final String title;
  final String date;
  final String image;
  final String text;
  final String imageUrl;
  final String url;
  final VoidCallback onImageTap;

  const Post({super.key,
    required this.title,
    required this.date,
    required this.image,
    required this.text,
    required this.imageUrl,
    required this.url,
    required this.onImageTap,
  });

   factory Post.fromJson(Map<String, dynamic> json) { 
      return Post(
        title: (json['discipline'] as String?) ?? '',
        text: (json['kindOfWork'] as String?) ?? '',
        image: (json['lecturer'] as String?) ?? '',
        imageUrl: (json['parentschedule'] as String?) ?? '',
        url: (json['author'] as String?) ?? '',
        date: (json['beginLesson'] as String?) ?? '',
        onImageTap:   () {
                      _launchURL('');
                    },
        // date: DateFormat('y.MM.dd').parse(json['date']) as String,// Переваем в строку
        // onImageTap: (((DateFormat('H:mm').parse(json['beginLesson']).hour)/2.4+(DateFormat('H:mm').parse(json['beginLesson']).minute)/60)*1.6).toString,
    );
  }



  @override
  Widget build(BuildContext context) {
    String safeImageUrl = imageUrl.isNotEmpty ? imageUrl : '';

    return GestureDetector(
      // onTap: onImageTap,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                maxLines: 3,
              ),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  safeImageUrl.isNotEmpty
                      ? ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      safeImageUrl,
                      width: 180,
                      height: 100,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                  (loadingProgress.expectedTotalBytes ?? 1)
                                  : null,
                            ),
                          );
                        }
                      },
                    ),
                  )
                      : const SizedBox(height: 100, width: 100, child: Icon(Icons.image, size: 50)),  // Заглушка, если нет изображения
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          text,
                          style: const TextStyle(color: Colors.black87),
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          date,
                          style: const TextStyle(color: Colors.black54, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}