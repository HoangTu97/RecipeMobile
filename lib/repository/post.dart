import 'package:recipes/dto/APIResponseDTO.dart';
import 'package:recipes/dto/ListResponseDTO.dart';
import 'package:recipes/dto/post/PostListItemResponseDTO.dart';
import 'package:recipes/models/index.dart';
import 'package:http/http.dart' as http;

abstract class PostRepository {
  Future<List<Post>> fetch(int page, int size);
}

class PostRepositoryImpl implements PostRepository {
  final http.Client httpClient = http.Client();

  PostRepositoryImpl();

  Future<List<Post>> fetch(int page, int size) async {
    final http.Response response = await http.get(Uri.http(
      "localhost:8080",
      "/api/public/post",
      {"page": "$page", "size": "$size"},
    ));

    if (response.statusCode != 200) {
      print('fetch -> Request failed with status: ${response.statusCode}.');
      throw Exception('error fetching posts');
    }

    APIResponseDTO apiResponseDTO = APIResponseDTO.fromJson(response.body);
    if (!apiResponseDTO.success) {
      print('fetch -> error:${apiResponseDTO.error}');
      throw Exception(apiResponseDTO.error);
    }

    ListResponseDTO listResponseDTO =
        ListResponseDTO.fromMap(apiResponseDTO.data);
    return listResponseDTO.items
        .map((e) => PostListItemResponseDTO.fromJson(e))
        .map((e) => Post.fromResponse(e))
        .toList();
  }
}

class FakePostRepositoryImpl implements PostRepository {
  Future<List<Post>> fetch(int page, int size) async {
    return List.filled(
      2,
      Post(
        id: null,
        userId: null,
        userName: "abc",
        recipeId: null,
        recipePhoto:
            "https://images.immediate.co.uk/production/volatile/sites/30/2020/08/chorizo-mozarella-gnocchi-bake-cropped-9ab73a3.jpg?webp=true&quality=90&resize=620%2C563",
        recipeTitle: "abc",
        recipeDesc: "abc",
        hashTags: ["abc", "bcd"],
        likes: 1,
      ),
    );
  }
}
