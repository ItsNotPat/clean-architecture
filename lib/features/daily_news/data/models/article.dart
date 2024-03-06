import 'package:clean_architecture/core/utils/app_utils.dart';
import 'package:clean_architecture/features/daily_news/domain/entities/article.dart';
import 'package:floor/floor.dart';

@Entity(tableName: 'articles', primaryKeys: ['id'])
class ArticleModel extends ArticleEntity {
  const ArticleModel({
    super.id,
    // Source? source,
    super.author,
    super.title,
    super.description,
    super.url,
    super.urlToImage,
    super.publishedAt,
    super.content,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> map) {
    return ArticleModel(
      id: map["id"] as String?,
      // source: Source.fromJson(map["source"] as Map<String, dynamic>),
      author: map["author"] as String?,
      title: map["title"] as String?,
      description: map["description"] as String?,
      url: map["url"] as String?,
      urlToImage: map["urlToImage"] as String?,
      publishedAt: map["publishedAt"] as String?,
      content: map["content"] as String?,
    );
  }

  factory ArticleModel.fromEntity(ArticleEntity entity) {
    return ArticleModel(
      id: entity.id ?? AppUtils.generateRandomString(12),
      // source: entity.source,
      author: entity.author,
      title: entity.title,
      description: entity.description,
      url: entity.url,
      urlToImage: entity.urlToImage,
      publishedAt: entity.publishedAt,
      content: entity.content,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      // "source": source?.toMap(),
      "author": author,
      "title": title,
      "description": description,
      "url": url,
      "urlToImage": urlToImage,
      "publishedAt": publishedAt,
      "content": content,
    };
  }
}

class Source {
  final String? id;
  final String? name;

  const Source({this.id, this.name});

  factory Source.fromJson(Map<String, dynamic> map) {
    return Source(
      id: map['id'] as String?,
      name: map['name'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
    };
  }
}
