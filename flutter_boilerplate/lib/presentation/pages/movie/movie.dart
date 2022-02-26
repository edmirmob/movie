import '../../../_all.dart';

class Movie extends StatefulWidget {
  const Movie({Key? key}) : super(key: key);

  @override
  _MovieState createState() => _MovieState();
}

class _MovieState extends State<Movie> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Expanded(flex: 1, child: SearchMovieWidget()),
        Expanded(flex: 5, child: MovieWidget()),
      ],
    );
  }
}
