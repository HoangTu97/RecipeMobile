import 'package:flutter/material.dart';
import 'package:recipes/services/locator.dart';
import 'package:recipes/services/navigation.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          children: <Widget>[
            ListTile(
              title: Row(
                children: <Widget>[
                  Icon(Icons.home),
                  SizedBox(width: 20),
                  Text('HOME'),
                ],
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Row(
                children: <Widget>[
                  Icon(Icons.content_paste),
                  SizedBox(width: 20),
                  Text('CATEGORIES'),
                ],
              ),
              onTap: () {
                locator<NavigationService>().pushNamed("/categories");
              },
            ),
          ],
        ),
      ),
    );
  }
}
