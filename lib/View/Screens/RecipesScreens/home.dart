import 'package:flutter/material.dart';
import 'package:project_pilot/View/Screens/RecipesScreens/recipes.dart';
import 'package:project_pilot/database/favorite_dao.dart';
import 'package:project_pilot/networking/joke_request.dart';
import 'package:project_pilot/networking/recipes_request.dart';
import 'package:project_pilot/ViewModel/favorite_view_model.dart';
import 'package:project_pilot/viewmodel/home_view_model.dart';
import 'package:project_pilot/viewmodel/joke_view_model.dart';
import 'package:project_pilot/viewmodel/recipes_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'favourite.dart';
import 'joke.dart';

class HomeScreen extends StatefulWidget {
  final HomeViewModel homeViewModel = HomeViewModel();

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> _currentWidget = <Widget>[
    RecipesScreen(RecipesViewModel(RecipesRequest())),
    FavoriteScreen(FavoriteViewModel(FavoriteDAO())),
    JokeScreen(JokeViewModel(JokeRequest())),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<int>(
          stream: widget.homeViewModel.indexSubject,
          builder: (context, snapshot) {
            return _currentWidget
                .elementAt(widget.homeViewModel.indexSubject.value);
          }),
      bottomNavigationBar: StreamBuilder<int>(
          stream: widget.homeViewModel.indexSubject,
          builder: (context, snapshot) {
            return bottomNav();
          }),
    );
  }

  BottomNavigationBar bottomNav() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.menu_book),
          label: AppLocalizations.of(context)?.recipes ?? '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.star),
          label: AppLocalizations.of(context)?.favorite ?? '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.tag_faces_outlined),
          label: AppLocalizations.of(context)?.joke ?? '',
        ),
      ],
      selectedItemColor: Colors.deepPurple,
      currentIndex: widget.homeViewModel.indexSubject.value,
      onTap: widget.homeViewModel.changeIndex,
    );
  }
}
