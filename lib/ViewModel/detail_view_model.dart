import 'package:flutter/material.dart';
import 'package:project_pilot/database/favorite_dao.dart';
import 'package:project_pilot/model/recipes.dart';
import 'package:project_pilot/model/recipes_overview.dart';
import 'package:project_pilot/networking/overview_request.dart';
import 'package:rxdart/rxdart.dart';

class DetailViewModel {
  BehaviorSubject<bool> isFavorite = BehaviorSubject.seeded(false);

  void checkFavoriteState(int id) async {
    FavoriteDAO fDAO = FavoriteDAO();
    List<int> listID = await fDAO.getAllID();
    for (int vl in listID) {
      if (vl == id) {
        isFavorite.sink.add(true);
        return;
      }
    }
  }

  void changeFavourite(BuildContext context, int id) async {
    FavoriteDAO fDAO = FavoriteDAO();
    RecipesDetailRequest req = RecipesDetailRequest();
    if (isFavorite.value) {
      isFavorite.value = false;
      await fDAO.deleteFavorite(id);
    } else {
      isFavorite.value = true;
      RecipesOverview recipesOverview = await req.getRecipesOverview(id: id);
      Recipes recipes = Recipes.fromRecipesOverview(recipesOverview);
      fDAO.insertFavorite(recipes);
    }
  }

  void dispose() {
    isFavorite.close();
  }
}
