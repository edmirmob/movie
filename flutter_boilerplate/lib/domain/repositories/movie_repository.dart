import 'package:flutter_boilerplate/_all.dart';
import 'package:rest_api_client/interfaces/_all.dart';

abstract class IMovieRepository {
  Future<MovieResponseData<MovieModel>?> fetchAllMovies(
      MovieSearchModel searchModel);
}

class MovieRepository implements IMovieRepository {
  final IRestApiClient restApiClient;
  MovieRepository({
    required this.restApiClient,
  });

  @override
  Future<MovieResponseData<MovieModel>> fetchAllMovies(
      MovieSearchModel searchModel) async {
    final List<MovieModel> allMovies = [];

    final response = await restApiClient.get(
        'http://www.omdbapi.com/?s=movie&apikey=28b534bd&page=${searchModel.page}');

    final responseDataItem = response.data['Search'] as List<dynamic>;
    final totalCount = response.data['totalResults'] as String;
    final isResponse = response.data['Response'] as String;
    if (isResponse == 'True') {
      for (final entity in responseDataItem) {
        allMovies.add(
          MovieModel.fromMap(entity),
        );
      }
    }

    return MovieResponseData(allMovies, totalCount, isResponse);
  }
}
