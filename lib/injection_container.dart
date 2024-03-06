import 'package:clean_architecture/features/daily_news/data/data_sources/local/app_database.dart';
import 'package:clean_architecture/features/daily_news/data/data_sources/remote/news_api_service.dart';
import 'package:clean_architecture/features/daily_news/data/repository/article_repository_impl.dart';
import 'package:clean_architecture/features/daily_news/domain/repository/article_repository.dart';
import 'package:clean_architecture/features/daily_news/domain/use_cases/delete_article.dart';
import 'package:clean_architecture/features/daily_news/domain/use_cases/get_article.dart';
import 'package:clean_architecture/features/daily_news/domain/use_cases/get_saved_article.dart';
import 'package:clean_architecture/features/daily_news/domain/use_cases/save_article.dart';
import 'package:clean_architecture/features/daily_news/presentation/bloc/article/local/local_article_bloc.dart';
import 'package:clean_architecture/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

final locator = GetIt.instance;

Future<void> initializeDependencies() async {
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  locator.registerSingleton<AppDatabase>(database);

  //Dio
  locator.registerSingleton<Dio>(Dio());

  //Dependencies
  locator.registerSingleton<NewsApiService>(NewsApiService(locator()));
  locator.registerSingleton<ArticleRepository>(
    ArticleRepositoryImpl(locator(), locator()),
  );

  //Use Cases
  locator.registerSingleton<GetArticleUseCase>(
    GetArticleUseCase(locator()),
  );
  locator.registerSingleton<GetSavedArticlesUseCase>(
    GetSavedArticlesUseCase(locator()),
  );
  locator.registerSingleton<SaveArticleUseCase>(
    SaveArticleUseCase(locator()),
  );
  locator.registerSingleton<DeleteArticleUseCase>(
    DeleteArticleUseCase(locator()),
  );

  //Blocs
  locator.registerFactory<RemoteArticlesBloc>(
    () => RemoteArticlesBloc(locator()),
  );

  locator.registerFactory<LocalArticlesBloc>(
    () => LocalArticlesBloc(locator(), locator(), locator()),
  );
}
