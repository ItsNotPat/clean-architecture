import 'dart:io';

import 'package:clean_architecture/features/daily_news/data/data_sources/local/app_database.dart';
import 'package:clean_architecture/features/daily_news/domain/entities/article.dart';
import 'package:dio/dio.dart';
import 'package:clean_architecture/core/constants/constants.dart';
import 'package:clean_architecture/core/resources/data_state.dart';
import 'package:clean_architecture/features/daily_news/data/data_sources/remote/news_api_service.dart';
import 'package:clean_architecture/features/daily_news/data/models/article.dart';

import '../../domain/repository/article_repository.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final NewsApiService _newsApiService;
  final AppDatabase _appDatabase;

  ArticleRepositoryImpl(this._newsApiService, this._appDatabase);

  @override
  Future<DataState<List<ArticleModel>>> getNewsArticles() async {
    try {
      final httpResponse = await _newsApiService.getNewsArticles(
        apiKey: apiKey,
        country: countryQuery,
        category: categoryQuery,
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        List<Map<String, dynamic>> listOfMaps =
            (httpResponse.data['articles'] as List).map((dynamic item) {
          return item as Map<String, dynamic>;
        }).toList();

        final List<ArticleModel> articles = listOfMaps
            .map<ArticleModel>(
                (articleJson) => ArticleModel.fromJson(articleJson))
            .toList();

        articles.removeWhere(
            (article) => article.title!.toLowerCase().contains("removed"));

        return DataSuccess(articles);
      } else {
        return DataFailed(
          DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions,
          ),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<List<ArticleEntity>> getSavedArticles() {
    return _appDatabase.articleDAO.getArticles();
  }

  @override
  Future<void> deleteSavedArticle(ArticleEntity article) async {
    await _appDatabase.articleDAO
        .deleteArticle(ArticleModel.fromEntity(article));
  }

  @override
  Future<void> saveArticle(ArticleEntity article) async {
    await _appDatabase.articleDAO
        .insertArticle(ArticleModel.fromEntity(article));
  }
}
