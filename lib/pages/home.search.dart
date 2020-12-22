import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/blocs/category/index.dart';
import 'package:recipes/models/category.dart';
import 'package:recipes/widgets/CategoryItem.dart';

class HomeSearchPage extends StatefulWidget {
  @override
  HomeSearchPageState createState() => new HomeSearchPageState();
}

class HomeSearchPageState extends State<HomeSearchPage> {
  CategoryBloc _categoryBloc;

  final _searchHolder = TextEditingController();
  Timer _debounce;

  @override
  void initState() {
    super.initState();

    _searchHolder.addListener(_onSearchChanged);

    _categoryBloc = BlocProvider.of<CategoryBloc>(context);
    _categoryBloc.add(CategoryFetched());
  }

  Future refreshData() async {
    _categoryBloc.add(CategoryFetched());
  }

  clearTextInput() {
    _searchHolder.clear();
  }

  _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      refreshData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Container(
          height: 40,
          padding: EdgeInsets.zero,
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
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: refreshData,
        child: CustomScrollView(
          shrinkWrap: true,
          slivers: [
            BlocBuilder<CategoryBloc, CategoryState>(builder: (context, state) {
              if (state is CategoryInitial) {
                return _cateloading();
              }
              if (state is CategorySuccess) {
                if (state.categories.isEmpty) {
                  return _cateFailed('no categories');
                }
                return _cateBody(state.categories);
              }
              if (state is CategoryFailure) {
                return _cateFailed('failed to fetch categories');
              }
              return _cateFailed('failed to fetch categories');
            }),
          ],
        ),
      ),
    );
  }

  Widget _cateFailed(String message) {
    return SliverToBoxAdapter(
      child: Container(
        height: 200,
        width: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(message),
              RaisedButton(
                color: Theme.of(context).primaryColor,
                onPressed: refreshData,
                child: Text('Tải lại'),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _cateloading() {
    return SliverToBoxAdapter(
      child: Container(
        height: 200,
        width: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              Text("Đang tải"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cateBody(List<Category> categories) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 300,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return CategoryItem(category: categories[index]);
        },
        childCount: categories.length,
      ),
    );
  }

  @override
  void dispose() {
    _searchHolder.removeListener(_onSearchChanged);
    _searchHolder.dispose();
    _debounce?.cancel();
    super.dispose();
  }
}
