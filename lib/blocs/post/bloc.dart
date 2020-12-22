import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:recipes/repository/index.dart';

import 'event.dart';
import 'state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository postRepository;

  PostBloc({@required this.postRepository}) : super(PostInitial());

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    final currentState = state;
    if (event is PostReload) {
      try {
        yield PostInitial();
        final posts = await postRepository.fetch(0, 20);
        yield PostSuccess(posts: posts, hasReachedMax: false);
        return;
      } catch (_) {
        yield PostFailure();
      }
    }
    if (event is PostFetched && !_hasReachedMax(currentState)) {
      try {
        if (currentState is PostInitial) {
          final posts = await postRepository.fetch(0, 20);
          yield PostSuccess(posts: posts, hasReachedMax: false);
          return;
        }
        if (currentState is PostSuccess) {
          final posts = await postRepository.fetch(
              (currentState.posts.length / 20).round(), 20);
          yield posts.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : PostSuccess(
                  posts: currentState.posts + posts,
                  hasReachedMax: false,
                );
        }
      } catch (_) {
        yield PostFailure();
      }
    }
  }

  bool _hasReachedMax(PostState state) =>
      state is PostSuccess && state.hasReachedMax;
}
