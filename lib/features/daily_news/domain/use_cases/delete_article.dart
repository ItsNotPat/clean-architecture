import 'package:clean_architecture/core/use_cases/use_case.dart';
import 'package:clean_architecture/features/daily_news/domain/entities/article.dart';
import 'package:clean_architecture/features/daily_news/domain/repository/article_repository.dart';

class DeleteArticleUseCase implements UseCase<void, ArticleEntity> {
  final ArticleRepository _articleRepository;

  DeleteArticleUseCase(this._articleRepository);

  @override
  Future<void> call({ArticleEntity? params}) async {
    return _articleRepository.deleteSavedArticle(params!);
  }
}
