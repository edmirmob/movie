import '../../_all.dart';

enum MovieStateStatus {
  loading,
  loaded,
  refreshed,
  loadedMore,

}

class MovieState {
  MovieStateStatus status;
  List<MovieModel> items;
  MovieSearchModel searchModel;
  String totalResult;

  MovieState({
    required this.status,
    required this.items,
    required this.searchModel,
    required this.totalResult,
  });

  MovieState copyWith({
    MovieStateStatus? status,
    List<MovieModel>? items,
    MovieSearchModel? searchModel,
    String? totalResult,
  }) {
    return MovieState(
        status: status ?? this.status,
        items: items ?? this.items,
        searchModel: searchModel ?? this.searchModel,
        totalResult: totalResult ?? this.totalResult
    );
  }
}