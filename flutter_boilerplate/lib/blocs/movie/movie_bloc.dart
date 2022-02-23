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
      );

  @override
  Stream<MovieState> mapEventToState(MovieEvent event) async* {
    if (event is MovieLoadsEvent) {
      yield* _loadMovies();
    } else if (event is MovieLoadEvent) {
      yield* _load(event);
    } else if (event is MovieRefreshEvent) {
      yield* _refresh();
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

  Stream<MovieState> _loadMovies() async* {
    if (await Permission.storage.check()) {
      yield state.copyWith(status: MovieStateStatus.loading);

      final movies = await movieRepository.fetchAllMovies();

      yield state.copyWith(status: MovieStateStatus.loaded, items: movies);
    }
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
    final items = await movieRepository.fetchAllMovies();

    yield state.copyWith(
      status: MovieStateStatus.refreshed,
      items: items,
    );
  }
}
