import 'package:clean_architecture/features/daily_news/domain/use_cases/delete_article.dart';
import 'package:clean_architecture/features/daily_news/domain/use_cases/get_saved_article.dart';
import 'package:clean_architecture/features/daily_news/domain/use_cases/save_article.dart';
import 'package:clean_architecture/features/daily_news/presentation/bloc/article/local/local_article_event.dart';
import 'package:clean_architecture/features/daily_news/presentation/bloc/article/local/local_article_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocalArticlesBloc extends Bloc<LocalArticlesEvent, LocalArticlesState> {
  final GetSavedArticlesUseCase _getSavedArticlesUseCase;
  final SaveArticleUseCase _saveArticleUseCase;
  final DeleteArticleUseCase _deleteArticleUseCase;

  LocalArticlesBloc(
    this._getSavedArticlesUseCase,
    this._saveArticleUseCase,
    this._deleteArticleUseCase,
  ) : super(const LocalArticlesLoading()) {
    on<GetSavedArticles>(onGetSavedArticles);
    on<DeleteArticle>(onDeleteArticle);
    on<SaveArticle>(onSaveArticle);
  }

  Future<void> onGetSavedArticles(
    GetSavedArticles event,
    Emitter<LocalArticlesState> state,
  ) async {
    final articles = await _getSavedArticlesUseCase();

    emit(LocalArticlesDone(articles));
  }

  Future<void> onDeleteArticle(
    DeleteArticle deleteArticle,
    Emitter<LocalArticlesState> state,
  ) async {
    emit(const LocalArticlesLoading());
    await _deleteArticleUseCase(params: deleteArticle.article);
    final articles = await _getSavedArticlesUseCase();

    emit(LocalArticlesDone(articles));
  }

  Future<void> onSaveArticle(
    SaveArticle saveArticle,
    Emitter<LocalArticlesState> state,
  ) async {
    await _saveArticleUseCase(params: saveArticle.article);
  }
}
