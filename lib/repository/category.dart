import 'package:recipes/dto/APIResponseDTO.dart';
import 'package:recipes/dto/ListResponseDTO.dart';
import 'package:recipes/dto/category/CategoryListItemResponseDTO.dart';
import 'package:recipes/models/index.dart';
import 'package:http/http.dart' as http;

abstract class CategoryRepository {
  Future<List<Category>> fetch();
}

class CategoryRepositoryImpl implements CategoryRepository {
  final http.Client httpClient = http.Client();

  CategoryRepositoryImpl();

  Future<List<Category>> fetch() async {
    final http.Response response =
        await http.get(Uri.http("localhost:8080", "/api/public/post"));

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
        .map((e) => CategoryListItemResponseDTO.fromMap(e))
        .map((e) => Category.fromResponse(e))
        .toList();
  }
}

class FakeCategoryRepositoryImpl implements CategoryRepository {
  Future<List<Category>> fetch() async {
    return List.filled(
      10,
      Category(
        id: 1,
        name: "abc",
        image:
            "https://images.immediate.co.uk/production/volatile/sites/30/2020/08/chorizo-mozarella-gnocchi-bake-cropped-9ab73a3.jpg?webp=true&quality=90&resize=620%2C563",
        numberRecipes: 1,
      ),
    );
  }
}
