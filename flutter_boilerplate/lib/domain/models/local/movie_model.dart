class MovieModel {
  final int? id;
  final String? title;
  final String? year;
  final String? type;
  final String? poster;

  MovieModel({this.id, this.title, this.year, this.poster, this.type});

  factory MovieModel.fromMap(Map<String, dynamic> map) {
    return MovieModel(
      id: map['id'],
      title: map['Title'],
      year: map['Year'],
      poster: map['Poster'],
      type: map['Type'],
    );
  }
}
