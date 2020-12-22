import 'package:flutter/material.dart';

class RecipeItem extends StatelessWidget {
  final int id;
  final String category;
  final String name;
  final String image;

  const RecipeItem({
    Key key,
    @required this.id,
    @required this.category,
    @required this.name,
    @required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/recipe",
            arguments: <String, dynamic>{'id': id});
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(image, height: 150, fit: BoxFit.cover),
            ),
            Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
            Spacer(),
            Text(category),
          ],
        ),
      ),
    );
  }
}
