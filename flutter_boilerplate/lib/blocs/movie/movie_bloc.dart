import 'package:permission_handler/permission_handler.dart';

import '../../_all.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final IMovieRepository movieRepository;

  MovieBloc({
    required this.movieRepository,
  }) : super(initialState());

  static MovieState initialState() => MovieState(
      status: MovieStateStatus.loading,
      items: [],
      searchModel: MovieSearchModel(),
      totalResult: '',
      errorMessage: '');

  @override
  Stream<MovieState> mapEventToState(MovieEvent event) async* {
    if (event is MovieLoadEvent) {
      yield* _load(event);
    } else if (event is MovieLoadMoreEvent) {
      yield* _loadMore();
    } else if (event is MovieRefreshEvent) {
      yield* _refresh();
    } else if (event is MovieSearchEvent) {
      yield* _search(event.searchModel);
    } else if (event is MovieResetEvent) {
      yield* _reset();
    } else if (event is MovieInitEvent) {
      yield* _init();
    }
  }

  Stream<MovieState> _init() async* {
    yield state.copyWith(
      status: MovieStateStatus.loaded,
      items: [],
    );
  }

  Stream<MovieState> _load(MovieLoadEvent event) async* {
    if (await Permission.storage.check()) {
      yield state.copyWith(
        status: MovieStateStatus.loading,
      );

      yield* _refresh();
    }
  }

  Stream<MovieState> _refresh() async* {
    final searchModel = state.searchModel;
    searchModel.reset();

    final items = await movieRepository.fetchAllMovies(searchModel);

    yield state.copyWith(
        status: MovieStateStatus.refreshed,
        items: items!.items,
        searchModel: searchModel,
        totalResult: items.totalCount,
        errorMessage: items.error);
  }

  Stream<MovieState> _loadMore() async* {
    final searchModel = state.searchModel;

    searchModel.increment();

    final items = await movieRepository.fetchAllMovies(searchModel);

    if (items?.items.isNotEmpty ?? true) {
      final all = List<MovieModel>.from(state.items);
      all.addAll(items!.items);

      yield state.copyWith(
        status: MovieStateStatus.loadedMore,
        items: all,
        totalResult: items.totalCount,
        searchModel: searchModel,
      );
    } else {
      yield state.copyWith(
          status: MovieStateStatus.loaded, totalResult: items!.totalCount);
    }
  }

  Stream<MovieState> _search(MovieSearchModel event) async* {
    final items = await movieRepository.fetchAllMovies(event);

    yield state.copyWith(
        status: MovieStateStatus.loaded,
        items: items!.items,
        totalResult: items.totalCount,
        errorMessage: items.error);
  }

  Stream<MovieState> _reset() async* {
    yield* _refresh();
  }
}
