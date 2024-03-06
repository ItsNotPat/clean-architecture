import 'package:clean_architecture/features/daily_news/domain/entities/article.dart';
import 'package:equatable/equatable.dart';

abstract class LocalArticlesEvent extends Equatable {
  final ArticleEntity? article;

  const LocalArticlesEvent({this.article});

  @override
  List<Object> get props => [article!];
}

class GetSavedArticles extends LocalArticlesEvent {
  const GetSavedArticles();
}

class DeleteArticle extends LocalArticlesEvent {
  const DeleteArticle(ArticleEntity entity) : super(article: entity);
}

class SaveArticle extends LocalArticlesEvent {
  const SaveArticle(ArticleEntity entity) : super(article: entity);
}
