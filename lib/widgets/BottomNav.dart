import 'package:flutter/material.dart';
import 'package:recipes/services/locator.dart';
import 'package:recipes/services/navigation.dart';

class BottomNav extends StatelessWidget {
  final int indexHighlight;

  const BottomNav({
    Key key,
    @required this.indexHighlight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.content_paste),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      selectedItemColor: Colors.amber[800],
      currentIndex: indexHighlight,
      onTap: (index) {
        if (index == indexHighlight) return;
        switch (index) {
          case 0:
            locator<NavigationService>().pushReplacementNamed("/");
            return;
          case 1:
            locator<NavigationService>().pushReplacementNamed("/categories");
            return;
        }
      },
    );
  }
}
