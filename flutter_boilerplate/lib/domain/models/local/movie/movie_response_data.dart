class MovieResponseData<T> {
  final List<T> items;
  final String totalCount;
  final String response;

  MovieResponseData(this.items, this.totalCount, this.response);
}
