import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_pilot/database/favorite_dao.dart';
import 'package:project_pilot/model/recipes.dart';
import 'package:rxdart/rxdart.dart';

class FavoriteViewModel {
  BehaviorSubject<List<Recipes>> listRecipesSubject =
      BehaviorSubject.seeded([]);
  BehaviorSubject<bool> isDeleted = BehaviorSubject();

  BehaviorSubject<bool> isShowAppBar = BehaviorSubject.seeded(false);

  Set<int> setID = {};

  final FavoriteDAO fDAO;

  FavoriteViewModel(this.fDAO);

  void addId(int id) {
    setID.add(id);
  }

  void showAppBar() {
    if (isShowAppBar.value == true) {
      return;
    }
    isShowAppBar.sink.add(true);
  }

  void closeAppBar() {
    setID.clear();
    isShowAppBar.sink.add(false);
  }

  void getFavorite() async {
    List<Recipes> list = await fDAO.getAllFavorite();
    listRecipesSubject.sink.add(list);
  }

  Future<void> deleteByID() async {
    int check = -1;
    for (int id in setID) {
      check = await fDAO.deleteFavorite(id);
    }
    if (check > 0) {
      isDeleted.sink.add(true);
      setID.clear();
      closeAppBar();
      getFavorite();
    } else {
      isDeleted.sink.add(false);
    }
  }

  Future<void> deleteAlLFavorite(BuildContext context) async {
    int check = await fDAO.deleteAllFavorite();
    if (check > 0) {
      isDeleted.sink.add(true);
      listRecipesSubject.sink.add([]);
    } else {
      isDeleted.sink.add(false);
    }
  }

  void dispose() {
    listRecipesSubject.close();
    isDeleted.close();
    isShowAppBar.close();
  }
}
