import '/../_all.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MovieWidget extends StatefulWidget {
  const MovieWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<MovieWidget> createState() => _MovieWidgetState();
}

class _MovieWidgetState extends State<MovieWidget> {
  final refreshController = RefreshController();

  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MovieBloc, MovieState>(
      listener: (context, movieState) {
        if (movieState.status == MovieStateStatus.loadedMore) {
          refreshController.loadComplete();
        }
        if (movieState.status == MovieStateStatus.loaded) {
          refreshController.loadComplete();
        }

        if (movieState.totalResult == movieState.items.length.toString()) {
          refreshController.loadComplete();
        }
        if (movieState.status == MovieStateStatus.refreshed) {
          refreshController.refreshCompleted();
        }
      },
      builder: (context, movieState) {
        return SmartRefresher(
          controller: refreshController,
          enablePullDown: true,
          enablePullUp: true,
          onLoading: () {
            context.read<MovieBloc>().add(MovieLoadMoreEvent());
          },
          onRefresh: () {
            context.read<MovieBloc>().add(MovieRefreshEvent());
          },
          child: () {
            if (movieState.status == MovieStateStatus.loading) {
              return const Loader();
            }

            return movieState.errorMessage == ''
                ? ListView.builder(
                    itemCount: movieState.items.count(),
                    physics: const ClampingScrollPhysics(),
                    controller: scrollController,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        shadowColor: Colors.white,
                        color: Colors.white70,
                        child: Stack(children: <Widget>[
                          Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Center(
                                    child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      topRight: Radius.circular(12)),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        '${movieState.items[index].poster}',
                                    width: double.infinity,
                                    height: 170,
                                    fit: BoxFit.cover,
                                    errorWidget: (context, error, stackTrace) {
                                      return Container(
                                        width: double.infinity,
                                        height: 170,
                                        child: Image.asset(
                                          AppAssets.placeholderPhoto,
                                          fit: BoxFit.cover,
                                        ),
                                      );
                                    },
                                  ),
                                )),
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.fromLTRB(
                                      8.0, 8.0, 8.0, 8.0),
                                  child: Text(
                                    '${movieState.items[index].title}',
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  child: Text(
                                    '${movieState.items[index].year}',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                const Spacing.verticalS(),
                              ]),
                        ]),
                      );
                    },
                  )
                : Center(
                    child: Container(
                      child: Text(
                        movieState.errorMessage,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  );
          }(),
        );
      },
    );
  }
}
