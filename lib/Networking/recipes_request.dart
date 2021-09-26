import 'package:dio/dio.dart';
import 'package:project_pilot/model/recipes.dart';
import 'package:project_pilot/networking/network.dart';
import 'package:project_pilot/Helper/Extension/map_extension.dart';

class RecipesRequest {
  Network network = Network(Dio());


  Future<List<Recipes>> getRecipes(Map<String, dynamic> params) async {
    try {
      final response = await network.getRequest(
          path: '/recipes/complexSearch', params: params);
      List<Recipes> listRecipes = [];
      if (response.statusCode == 200) {
        Map<String, dynamic> result = response.data as Map<String, dynamic>;
        if (result.containsKey('results')) {
          var json = result.toList('results');
          for (var item in json) {
            Recipes recipes = Recipes.fromJson(item);
            listRecipes.add(recipes);
          }
        }
      }
      return listRecipes;
    } catch (e) {
      if(e ==  'No Internet'){
        return Future.error('No Internet');
      }
      throw 'Lỗi get recipes $e';
    }
  }
}
