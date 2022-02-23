import 'package:flutter_boilerplate/_all.dart';
import 'package:rest_api_client/interfaces/_all.dart';

abstract class IMovieRepository {
  Future<List<MovieModel>?> fetchAllMovies();
}

class MovieRepository implements IMovieRepository {
  final IRestApiClient restApiClient;
  MovieRepository({
    required this.restApiClient,
  });

  @override
  Future<List<MovieModel>> fetchAllMovies() async {
    final List<MovieModel> allMovies = [];

    final response = await restApiClient
        .get('http://www.omdbapi.com/?s=movie&apikey=28b534bd');

    final responseDataItem = response.data['Search'] as List<dynamic>;

    for (final entity in responseDataItem) {
      allMovies.add(
        MovieModel.fromMap(entity),
      );
    }

    return allMovies;
  }
}
