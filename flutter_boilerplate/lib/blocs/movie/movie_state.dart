import 'package:flutter_boilerplate/_all.dart';
import 'package:flutter_boilerplate/domain/models/local/movie_model.dart';

enum MovieStateStatus {
  loading,
  loaded,
  refreshed,
}

class MovieState {
  MovieStateStatus status;
  List<MovieModel> items;

  MovieState({
    required this.status,
    required this.items,
  });

  MovieState copyWith({
    MovieStateStatus? status,
    List<MovieModel>? items,
  }) {
    return MovieState(
      status: status ?? this.status,
      items: items ?? this.items,
    );
  }
}
