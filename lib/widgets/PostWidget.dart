import 'package:flutter/material.dart';
import 'package:recipes/models/post.dart';

class PostWidget extends StatelessWidget {
  final Post post;

  const PostWidget({Key key, @required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/recipe",
            arguments: <String, dynamic>{'id': post.recipeId});
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.width * 0.5,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                child: Image.network(post.recipePhoto, fit: BoxFit.cover),
              ),
            ),
            Row(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  margin: EdgeInsets.all(10),
                  child: CircleAvatar(
                    radius: double.infinity,
                    backgroundImage: AssetImage("assets/avatar.jpg"),
                  ),
                ),
                Text(post.userName,
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            Text(post.recipeTitle,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            Text(post.hashTags.join(",")),
          ],
        ),
      ),
    );
  }
}
