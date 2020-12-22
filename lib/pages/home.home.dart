import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/blocs/recipe/index.dart';
import 'package:recipes/widgets/RecipeItem.dart';

class HomeHomePage extends StatefulWidget {
  @override
  HomeHomePageState createState() => new HomeHomePageState();
}

class HomeHomePageState extends State<HomeHomePage> {
  final _scrollController = ScrollController(initialScrollOffset: 0.5);
  final _searchHolder = TextEditingController();
  Timer _debounce;

  RecipeBloc _recipeBloc;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(scrollListener);
    _searchHolder.addListener(_onSearchChanged);

    _recipeBloc = BlocProvider.of<RecipeBloc>(context);
    _recipeBloc.add(RecipeFetched());
  }

  scrollListener() {
    var triggerFetchMoreSize = 0.9 * _scrollController.position.maxScrollExtent;
    if (_scrollController.position.pixels <= triggerFetchMoreSize) {
      return;
    }
    _recipeBloc.add(RecipeFetched(text: _searchHolder.text));
  }

  refreshData() {
    _recipeBloc.add(RecipeReload(text: _searchHolder.text));
  }

  clearTextInput() {
    _searchHolder.clear();
    search();
  }

  search() {
    _recipeBloc.add(RecipeReload(text: _searchHolder.text));
  }

  _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      search();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Container(
          height: 40,
          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          child: TextField(
            maxLines: 1,
            decoration: InputDecoration(
              hintText: "Search",
              border: InputBorder.none,
              prefixIcon: Icon(Icons.search, size: 25),
              suffixIcon: IconButton(
                onPressed: clearTextInput,
                icon: Icon(Icons.close, size: 20),
              ),
            ),
            controller: _searchHolder,
            autofocus: true,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 50,
          ),
          BlocBuilder<RecipeBloc, RecipeState>(
            builder: (context, state) {
              if (state is RecipeInitial) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is RecipeFailure) {
                return _buildFailed();
              }
              if (state is RecipeSuccess) {
                if (state.recipes.isEmpty) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('no recipes'),
                      RaisedButton(
                        color: Theme.of(context).primaryColor,
                        onPressed: refreshData,
                        child: Text('Tải lại'),
                      )
                    ],
                  );
                }
                return GridView.count(
                  padding: EdgeInsets.all(20),
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 0.75,
                  controller: _scrollController,
                  children: List.generate(
                    state.recipes.length,
                    (index) {
                      return RecipeItem(
                        id: state.recipes[index].id,
                        name: state.recipes[index].title,
                        category: state.recipes[index].categories.length == 0
                            ? ""
                            : state.recipes[index].categories[0],
                        image: state.recipes[index].photoUrl,
                      );
                    },
                  ),
                );
              }
              return _buildFailed();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFailed() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('failed to fetch recipes'),
          RaisedButton(
            color: Theme.of(context).primaryColor,
            onPressed: refreshData,
            child: Text('Tải lại'),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchHolder.removeListener(_onSearchChanged);
    _searchHolder.dispose();
    _debounce?.cancel();
    super.dispose();
  }
}
