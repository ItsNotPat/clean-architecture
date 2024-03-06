import 'package:clean_architecture/features/daily_news/data/models/article.dart';
import 'package:equatable/equatable.dart';

class ArticleEntity extends Equatable {
  final String? id;
  // final Source? source;
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;

  const ArticleEntity({
    this.id,
    // this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  factory ArticleEntity.fromModel(ArticleModel model) {
    return ArticleEntity(
      id: model.id,
      // source: model.source,
      author: model.author,
      title: model.title,
      description: model.description,
      url: model.url,
      urlToImage: model.urlToImage,
      publishedAt: model.publishedAt,
      content: model.content,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      // source,
      author,
      title,
      description,
      url,
      urlToImage,
      publishedAt,
      content,
    ];
  }
}
