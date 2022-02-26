import 'package:flutter_boilerplate/_all.dart';

import '../pages/movie/movie_widget.dart';

class NavigationWrapper extends StatefulWidget {
  @override
  State<NavigationWrapper> createState() => _NavigationWrapperState();
}

class _NavigationWrapperState extends State<NavigationWrapper> {
  @override
  void initState() {
    super.initState();
    context.read<MovieBloc>().add(MovieLoadEvent());
    context.locationBloc.add(LocationCheckEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: () {
            switch (state.index) {
              case 0:
                return Scaffold(
                  resizeToAvoidBottomInset: false,
                  appBar: AppBar(
                    title: Text(context.translations.applicationName),
                    elevation: 4,
                  ),
                  body: const Movie(),
                  // const Center(child: Text('First page')),
                );
              case 1:
                return Scaffold(
                  appBar:
                      AppBar(title: Text(context.translations.applicationName)),
                  body: const Center(child: Text('Second page')),
                );
              case 2:
                return Scaffold(
                  appBar:
                      AppBar(title: Text(context.translations.applicationName)),
                  body: const Center(child: Text('Third page')),
                );
            }
          }(),
          bottomNavigationBar: _buildBottomNavigationBar(context, state.index),
        );
      },
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context, int currentIndex) {
    return BottomNavigationBar(
      onTap: (index) => context
          .read<NavigationBloc>()
          .add(NavigationChangeIndexEvent(index: index)),
      currentIndex: currentIndex,
      items: const [
        BottomNavigationBarItem(
          label: 'First',
          icon: Icon(Icons.home),
        ),
        BottomNavigationBarItem(
          label: 'Second',
          icon: Icon(Icons.security),
        ),
        BottomNavigationBarItem(
          label: 'Third',
          icon: Icon(Icons.settings),
        ),
      ],
    );
  }
}
