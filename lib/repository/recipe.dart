import 'package:recipes/dto/APIResponseDTO.dart';
import 'package:recipes/dto/ListResponseDTO.dart';
import 'package:recipes/dto/recipe/RecipeListItemResponseDTO.dart';
import 'package:http/http.dart' as http;

import 'package:recipes/models/recipe.dart';
import 'package:recipes/models/recipe_detail.dart';

abstract class RecipeRepository {
  Future<List<Recipe>> fetch(String searchTxt, int page, int size);
  Future<RecipeDetail> detail(int id);
}

class RecipeRepositoryImpl extends RecipeRepository {
  final http.Client httpClient = http.Client();

  RecipeRepositoryImpl();

  Future<List<Recipe>> fetch(String searchTxt, int page, int size) async {
    final http.Response response = await httpClient.get(Uri.http(
      "localhost:8080",
      searchTxt == '' || searchTxt == null
          ? "/api/public/recipe/getAll"
          : "/api/public/recipe/searchByRecipeName",
      searchTxt == '' || searchTxt == null
          ? {"page": "$page", "size": "$size"}
          : {"page": "$page", "size": "$size", "name": searchTxt},
    ));

    if (response.statusCode != 200) {
      print('fetch -> Request failed with status: ${response.statusCode}.');
      throw Exception('error fetching recipes');
    }

    APIResponseDTO apiResponseDTO = APIResponseDTO.fromJson(response.body);
    if (!apiResponseDTO.success) {
      print('fetch -> error:${apiResponseDTO.error}');
      throw Exception(apiResponseDTO.error);
    }

    ListResponseDTO listResponseDTO =
        ListResponseDTO.fromMap(apiResponseDTO.data);
    return listResponseDTO.items
        .map((e) => RecipeListItemResponseDTO.fromMap(e))
        .map((e) => Recipe.fromResponse(e))
        .toList();
  }

  Future<RecipeDetail> detail(int id) async {
    final http.Response response = await httpClient
        .get(Uri.http("localhost:8080", "/api/public/recipe/detail/$id"));

    if (response.statusCode != 200) {
      print('detail -> Request failed with status: ${response.statusCode}.');
      throw Exception('error fetching recipes');
    }

    APIResponseDTO apiResponseDTO = APIResponseDTO.fromJson(response.body);
    if (!apiResponseDTO.success) {
      print('detail -> error:${apiResponseDTO.error}');
      throw Exception(apiResponseDTO.error);
    }

    return RecipeDetail.fromResponse(apiResponseDTO.data);
  }
}

class FakeRecipeRepositoryImpl extends RecipeRepository {
  final http.Client httpClient = http.Client();

  FakeRecipeRepositoryImpl();

  Future<List<Recipe>> fetch(String searchTxt, int page, int size) async {
    return List.filled(
        5,
        Recipe(
          id: 1,
          title: "abc",
          photoUrl: "abc",
          categories: ["abc", "def"],
        ));
  }

  Future<RecipeDetail> detail(int id) async {
    return RecipeDetail(
      id: 1,
      photos: [
        "https://images.unsplash.com/photo-1533777324565-a040eb52facd?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80"
      ],
      title: "Hàu chiên trứng",
      categories: ["Hải sản"],
      duration: 120,
      description: "Các bước làm",
      steps: [
        "Hàu rửa với nước muối, xả lại dưới vòi nước nhẹ hàng. Trứng đánh lên, nêm hạt nêm, tiêu. Đầu hành cắt nhuyễn.",
        "Phi thơm đầu hành, cho tiếp hàu vào xào 1 phút với lửa to nhất, múc bớt nước hàu ra, sau đó mới cho trứng vào.",
        "Cho trứng và hành vào, hạ lửa nhỏ, đậy nắp chảo lại để chín trứng phía trên, chiên tiếp 2p thì tắt bếp. Cho ra dĩa rắc thêm tiêu, ngò.",
      ],
    );
  }
}
