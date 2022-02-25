import 'package:flutter_boilerplate/_all.dart';

class MovieSearchModel extends Pagination {
  String? title;
  MovieSearchModel({
    this.title,
  }) : super();

  MovieSearchModel copyWith({
    String? title,
  }) {
    return MovieSearchModel(
      title: title != null ? title.value : this.title,
    );
  }
}
