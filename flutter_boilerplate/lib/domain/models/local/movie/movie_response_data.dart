class MovieResponseData<T> {
  final List<T> items;
  final String totalCount;
  final String response;
  final String error;
  MovieResponseData(
    this.items,
    this.totalCount,
    this.response,
    this.error,
  );
}
