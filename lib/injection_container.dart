import 'package:get_it/get_it.dart';
import 'package:nyt_api_test/repositories/news_repository.dart';

var getIt = GetIt.instance;

void setupInj() {
  getIt.registerLazySingleton(() => NewsRepository());
}
