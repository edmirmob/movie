import 'package:flutter_boilerplate/_all.dart';
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

  @override
  void dispose() {
    refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MovieBloc, MovieState>(
      listener: (context, movieState) {
        if ([
          MovieStateStatus.loaded,
        ].contains(movieState.status)) {
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
          enablePullUp: false,
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

            return ListView.builder(
              itemCount: movieState.items.count(),
              itemBuilder: (context, index) {
                return Card(
                  elevation: 4,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  shadowColor: Colors.white,
                  color: Colors.white70,
                  child: Stack(children: <Widget>[
                    Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                      Center(
                        child: Image(
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              '${movieState.items[index].poster}'),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        color: Colors.white,
                        padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
                        child: Text(
                          '${movieState.items[index].title}',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        color: Colors.white,
                        padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
                        child: Text(
                          '${movieState.items[index].year}',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ]),
                  ]),
                );
              },
            );
          }(),
        );
      },
    );
  }
}
