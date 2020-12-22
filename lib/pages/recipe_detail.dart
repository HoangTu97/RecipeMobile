import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:recipes/blocs/recipe_details/index.dart';

class RecipeDetailPage extends StatefulWidget {
  final int id;

  const RecipeDetailPage({
    Key key,
    @required this.id,
  }) : super(key: key);

  @override
  RecipeDetailPageState createState() => new RecipeDetailPageState();
}

class RecipeDetailPageState extends State<RecipeDetailPage> {
  RecipeDetailBloc _recipeDetailBloc;

  @override
  void initState() {
    super.initState();

    _recipeDetailBloc = BlocProvider.of<RecipeDetailBloc>(context);
    _recipeDetailBloc.add(RecipeDetailFetched());
  }

  Future getData() async {
    _recipeDetailBloc.add(RecipeDetailFetched());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                SizedBox(
                  height: 250,
                  child: BlocBuilder<RecipeDetailBloc, RecipeDetailState>(
                    builder: (context, state) {
                      if (state is RecipeDetailSuccess) {
                        return Carousel(
                          dotBgColor: Colors.transparent,
                          dotSize: 4.0,
                          dotSpacing: 15.0,
                          indicatorBgPadding: 5.0,
                          autoplay: false,
                          images: state.detail.photos
                              .map((e) => NetworkImage(e))
                              .toList(),
                        );
                      }
                      return Image.network(
                          "https://images.unsplash.com/photo-1533777324565-a040eb52facd?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80");
                    },
                  ),
                ),
                Positioned(
                  left: 10,
                  top: 40,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Icon(
                        Icons.chevron_left,
                        color: Colors.lightGreen,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            BlocBuilder<RecipeDetailBloc, RecipeDetailState>(
              builder: (context, state) {
                if (state is RecipeDetailSuccess) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 25),
                      Center(
                        child: Text(
                          state.detail.title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: Text(
                          state.detail.categories[0],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.lightGreen,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.timer),
                          Text(
                            "${state.detail.duration} minutes",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      // SizedBox(height: 20),
                      // Center(
                      //   child: Container(
                      //     height: 45,
                      //     width: 275,
                      //     decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(25),
                      //       border: Border.all(color: Colors.lightGreen),
                      //     ),
                      //     child: Center(
                      //       child: Text(
                      //         "View Ingredients",
                      //         textAlign: TextAlign.center,
                      //         style: TextStyle(color: Colors.lightGreen),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      SizedBox(height: 25),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        child: Text(state.detail.description),
                      ),
                      SizedBox(height: 75),
                    ],
                  );
                }
                return Container(
                  child: Text("no data"),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}