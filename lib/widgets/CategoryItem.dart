import 'package:flutter/material.dart';
import 'package:recipes/models/index.dart';

class CategoryItem extends StatelessWidget {
  final Category category;

  const CategoryItem({
    Key key,
    @required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 150,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              child: Image.network(
                category.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            category.name,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text("${category.numberRecipes} recipes"),
        ],
      ),
    );
  }
}
