import '../../../_all.dart';

class SearchMovieWidget extends StatefulWidget {
  const SearchMovieWidget({Key? key}) : super(key: key);

  @override
  _SearchMovieWidgetState createState() => _SearchMovieWidgetState();
}

class _SearchMovieWidgetState extends State<SearchMovieWidget> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(
          right: 30,
          left: 30,
          top: 20,
        ),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: const [
              _MovieTitleWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class _MovieTitleWidget extends StatelessWidget {
  const _MovieTitleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieBloc, MovieState>(
      builder: (context, movieState) {
        return SearchField(
          initialValue: '',
          onChanged: (String value) {
            context.movieBloc.add(
                  MovieSearchEvent(searchModel: movieState.searchModel.copyWith(title: value)),
                );
          },
          hint: context.localizer.translations.tapToSearch,
        );
      },
    );
  }
}
