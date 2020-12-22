import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/blocs/category/bloc.dart';
import 'package:recipes/blocs/post/bloc.dart';
import 'package:recipes/pages/home.newsfeed.dart';
import 'package:recipes/pages/home.profile.dart';
import 'package:recipes/repository/index.dart';

import 'home.search.dart';

class Destination {
  final int index;
  final String title;
  final IconData icon;
  final Widget child;

  const Destination({
    @required this.index,
    @required this.title,
    @required this.icon,
    @required this.child,
  });
}

List<Destination> allDestinations = <Destination>[
  Destination(
    index: 0,
    title: 'Home',
    icon: Icons.home,
    child: RepositoryProvider<PostRepository>(
      create: (_) => FakePostRepositoryImpl(),
      child: BlocProvider<PostBloc>(
        create: (context) => PostBloc(
            postRepository: RepositoryProvider.of<PostRepository>(context)),
        child: HomeNewsFeedPage(),
      ),
    ),
  ),
  Destination(
    index: 1,
    title: 'Search',
    icon: Icons.search,
    child: RepositoryProvider<CategoryRepository>(
      create: (_) => FakeCategoryRepositoryImpl(),
      child: BlocProvider<CategoryBloc>(
        create: (context) => CategoryBloc(
            categoryRepository:
                RepositoryProvider.of<CategoryRepository>(context)),
        child: HomeSearchPage(),
      ),
    ),
  ),
  Destination(
      index: 2, title: 'Profile', icon: Icons.person, child: HomeProfilePage())
];

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with TickerProviderStateMixin<HomePage> {
  List<AnimationController> _faders;
  List<Key> _destinationKeys;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    _faders =
        allDestinations.map<AnimationController>((Destination destination) {
      return AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 200),
      );
    }).toList();
    _faders[_currentIndex].value = 1.0;
    _destinationKeys =
        List<Key>.generate(allDestinations.length, (int index) => GlobalKey())
            .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Stack(
          fit: StackFit.expand,
          children: allDestinations.map((Destination destination) {
            final Widget view = FadeTransition(
              opacity: _faders[destination.index]
                  .drive(CurveTween(curve: Curves.fastOutSlowIn)),
              child: KeyedSubtree(
                key: _destinationKeys[destination.index],
                child: destination.child,
              ),
            );
            if (destination.index == _currentIndex) {
              _faders[destination.index].forward();
              return view;
            } else {
              _faders[destination.index].reverse();
              if (_faders[destination.index].isAnimating) {
                return IgnorePointer(child: view);
              }
              return Offstage(child: view);
            }
          }).toList(),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: allDestinations.map((Destination destination) {
          return BottomNavigationBarItem(
            icon: Icon(destination.icon),
            label: destination.title,
          );
        }).toList(),
      ),
    );
  }

  @override
  void dispose() {
    for (AnimationController controller in _faders) controller.dispose();
    super.dispose();
  }
}
