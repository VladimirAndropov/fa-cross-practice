import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(ProviderScope(child: MultipleCategorySelection()));
}

final articleRepository = Provider<ArticleRepository>(
  (ref) => FakeArticleRepository(),
);

final articles = FutureProvider<List<Article>>((ref) async {
  return ref.watch(articleRepository).fetchArticles();
});

class MultipleCategorySelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(title: Text("Flutter Riverpod Future")),
        body: Column(
          children: [
            ArticleList(),
          ],
        ),
      ),
    );
  }
}

class ArticleList extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final article = ref.watch(articles);
    return article.when(
        loading: () => Center(child: const CircularProgressIndicator()),
        error: (err, stack) => Text('Error: $err'),
        data: (articles) {
          return Flexible(
            child: ListView.builder(
                itemCount: articles.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                      title: Text(articles[index].name),
                      subtitle: Row(
                        children: [
                          Icon(Icons.thumb_up),
                          Text(" ${articles[index].likes}")
                        ],
                      ));
                }),
          );
        });
  }
}

abstract class ArticleRepository {
  Future<List<Article>> fetchArticles();
}

class FakeArticleRepository implements ArticleRepository {
  @override
  Future<List<Article>> fetchArticles() {
    return Future.delayed(
      Duration(milliseconds: 1000),
      () {
        var r = Random();
        return [
          Article("Flutter Riverpod Testing – Example", r.nextInt(30)),
          Article("Flutter Hooks – Testing Your Widgets", r.nextInt(30)),
          Article("Riverpod State Management Example", r.nextInt(30)),
          Article("Flutter Freezed – Working with Immutable’s", r.nextInt(30)),
          Article("Animations on Value Changed with Riverpod", r.nextInt(30))
        ];
      },
    );
  }
}

class Article {
  final String name;
  final int likes;

  Article(this.name, this.likes);
}