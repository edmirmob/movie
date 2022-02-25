import '../../_all.dart';

abstract class MovieEvent {}

class MovieLoadsEvent extends MovieEvent {}

class MovieInitEvent extends MovieEvent {}

class MovieLoadEvent extends MovieEvent {
  final MovieSearchModel? searchModel;

  MovieLoadEvent({this.searchModel});
}
class MovieSearchEvent extends MovieEvent {
  final MovieSearchModel searchModel;


  MovieSearchEvent({
    required this.searchModel,
   
  });
}

class MovieRefreshEvent extends MovieEvent {}

class MovieLoadMoreEvent extends MovieEvent {}

class MovieResetEvent extends MovieEvent {}
