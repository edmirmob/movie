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
  String errorMessage;

  MovieState({
    required this.status,
    required this.items,
    required this.searchModel,
    required this.totalResult,
    required this.errorMessage,

  });

  MovieState copyWith({
    MovieStateStatus? status,
    List<MovieModel>? items,
    MovieSearchModel? searchModel,
    String? totalResult,
    String ? errorMessage,
  }) {
    return MovieState(
        status: status ?? this.status,
        items: items ?? this.items,
        searchModel: searchModel ?? this.searchModel,
        totalResult: totalResult ?? this.totalResult,
        errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}