import 'dart:async';

import 'package:project_pilot/model/recipes.dart';
import 'package:project_pilot/networking/recipes_request.dart';
import 'package:rxdart/rxdart.dart';

class RecipesViewModel {
  BehaviorSubject<List<Recipes>> listRecipesSubject = BehaviorSubject();

  BehaviorSubject<int> indexOfFilterSubject = BehaviorSubject.seeded(0);

  BehaviorSubject<int> indexOfFilterByMealSubject = BehaviorSubject.seeded(0);

  BehaviorSubject<int> indexOfFilterByDietSubject = BehaviorSubject.seeded(0);

  BehaviorSubject<bool> isShowSearchEdt = BehaviorSubject.seeded(false);

  BehaviorSubject<String> searchQuerySubject = BehaviorSubject();

  BehaviorSubject<bool> hasInternetConnection = BehaviorSubject();

  RecipesRequest request;

  RecipesViewModel(this.request);

  final listFilter1 = [
    'All',
    'Newest',
    'Top Rated',
    'Most Popular',
    'Trendy',
    'Most Liked'
  ];

  final listFilterByMealType = [
    'Main course',
    'Snack',
    'Dessert',
    'Appetizer',
    'Drink',
    'Salad',
    'Finger food'
  ];

  final listFilterByDietType = [
    'Vegan',
    'Vegetarian',
    'Ketogenic',
    'Dairy Free',
    'Gluten Free',
    'Paleo',
    'Lacto-Vegetarian'
  ];

  void sortFilter() async {
    List<Recipes> listRecipes = listRecipesSubject.value;
    if (indexOfFilterSubject.value == 0) {
      await getRecipes(number: 100, offset: 0)
          .then((value) => listRecipesSubject.sink.add(value))
          .onError((error, stackTrace) {
        listRecipesSubject.sink.addError(error ?? '');
      });
    } else if (indexOfFilterSubject.value == 1) {
      listRecipes = sortByNewest(listRecipes);
      listRecipesSubject.sink.add(listRecipes);
    } else {
      listRecipes = sortByTopRated(listRecipes);
      listRecipesSubject.sink.add(listRecipes);
    }
  }

  List<Recipes> sortByNewest(List<Recipes> list) {
    for (int i = 0; i < list.length - 1; i++) {
      for (int j = i + 1; j < list.length; j++) {
        if ((list[i].readyInMinutes ?? 0) < (list[j].readyInMinutes ?? 0)) {
          var temp = list[i];
          list[i] = list[j];
          list[j] = temp;
        }
      }
    }
    return list;
  }

  List<Recipes> sortByTopRated(List<Recipes> list) {
    for (int i = 0; i < list.length - 1; i++) {
      for (int j = i + 1; j < list.length; j++) {
        if ((list[i].likesNumber ?? 0) < (list[j].likesNumber ?? 0)) {
          var temp = list[i];
          list[i] = list[j];
          list[j] = temp;
        }
      }
    }
    return list;
  }

  void setShowSearchEdt() {
    isShowSearchEdt.sink.add(!isShowSearchEdt.value);
  }

  Map<String, dynamic> params(
      {String query = '',
      int offset = 0,
      int number = 20,
      String diet = '',
      String type = ''}) {
    return {
      'query': query,
      'offset': offset,
      'number': number,
      'addRecipeInformation': true,
      'type': type,
      'diet': diet,
      'titleMatch': query,
    };
  }

  Future<List<Recipes>> getRecipes(
      {String query = '', int offset = 0, int number = 20}) async {
    List<Recipes> list = [];
    await request.getRecipes(params()).then((value) {
      listRecipesSubject.sink.add(value);
    }).onError((error, stackTrace) {
      listRecipesSubject.sink.addError(error ?? '');
    });
    return list;
  }

  void getRecipes2({String query = '', int offset = 0, int number = 20}) async {
    await request.getRecipes(
        {'query': query, 'addRecipeInformation': true}).then((value) {
      listRecipesSubject.sink.add(value);
    }).onError((error, stackTrace) {
      listRecipesSubject.sink.addError(error ?? '');
    });
  }

  void searchRecipes() async {
    searchQuerySubject
        .debounceTime(Duration(milliseconds: 500))
        .listen((event) {
      getRecipes2(query: event);
    });
  }

  void addValue(String value) {
    searchQuerySubject.sink.add(value);
  }

  void getRecipesByTypeAndDiet() async {
    await request
        .getRecipes(
          params(
            type: listFilterByMealType[indexOfFilterByMealSubject.value],
            diet: listFilterByDietType[indexOfFilterByDietSubject.value],
          ),
        )
        .then((value) => listRecipesSubject.sink.add(value))
        .onError((error, stackTrace) =>
            listRecipesSubject.sink.addError(error ?? ''));
  }

  void setCheckedFilter(int index) {
    indexOfFilterSubject.sink.add(index);
  }

  void setCheckedFilterByMeal(int index) {
    indexOfFilterByMealSubject.sink.add(index);
  }

  void setCheckedFilterByDiet(int index) {
    indexOfFilterByDietSubject.sink.add(index);
  }

  void dispose() {
    listRecipesSubject.close();
    indexOfFilterByMealSubject.close();
    indexOfFilterSubject.close();
    indexOfFilterByDietSubject.close();
    isShowSearchEdt.close();
    searchQuerySubject.close();
    hasInternetConnection.close();
  }
}
