import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/blocs/post/index.dart';
import 'package:recipes/widgets/BottomLoader.dart';
import 'package:recipes/widgets/PostForm.dart';
import 'package:recipes/widgets/PostWidget.dart';

class HomeNewsFeedPage extends StatefulWidget {
  @override
  HomeNewsFeedPageState createState() => new HomeNewsFeedPageState();
}

class HomeNewsFeedPageState extends State<HomeNewsFeedPage> {
  final _scrollController = ScrollController(initialScrollOffset: 0.5);
  final _searchHolder = TextEditingController();

  PostBloc _postBloc;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(scrollListener);

    _postBloc = BlocProvider.of<PostBloc>(context);
    _postBloc.add(PostFetched());
  }

  scrollListener() {
    var triggerFetchMoreSize = 0.9 * _scrollController.position.maxScrollExtent;
    if (_scrollController.position.pixels <= triggerFetchMoreSize) {
      return;
    }
    _postBloc.add(PostFetched());
  }

  Future<void> refreshData() async {
    _postBloc.add(PostReload());
  }

  clearTextInput() {
    _searchHolder.clear();
    search();
  }

  void search() {
    refreshData();
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
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: refreshData,
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate([
                PostForm(),
                BlocBuilder<PostBloc, PostState>(builder: (context, state) {
                  if (state is PostInitial) {
                    return _postLoading();
                  }
                  if (state is PostSuccess) {
                    if (state.posts.isEmpty) {
                      return _postFailed('no posts');
                    }
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        state.hasReachedMax
                            ? state.posts.length
                            : state.posts.length + 1,
                        (index) => index >= state.posts.length
                            ? BottomLoader()
                            : PostWidget(post: state.posts[index]),
                      ),
                    );
                  }
                  if (state is PostFailure) {
                    return _postFailed('failed to fetch posts');
                  }
                  return _postFailed('failed to fetch posts');
                }),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _postFailed(String message) {
    return Container(
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
    );
  }

  Widget _postLoading() {
    return Container(
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
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchHolder.dispose();
    super.dispose();
  }
}
