import 'package:flutter/material.dart';
import 'package:project_pilot/networking/ingredient_request.dart';
import 'package:project_pilot/networking/instruction_request.dart';
import 'package:project_pilot/networking/overview_request.dart';
import 'package:project_pilot/viewmodel/detail_view_model.dart';
import 'package:project_pilot/viewmodel/ingredient_view_model.dart';
import 'package:project_pilot/viewmodel/instruction_view_model.dart';
import 'package:project_pilot/viewmodel/overview_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'ingredient.dart';
import 'instruction.dart';
import 'overview.dart';

class DetailScreen extends StatelessWidget {
  final int id;
  final DetailViewModel detailViewModel;

  DetailScreen(this.id, this.detailViewModel);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Color(0xFFFFFFFF),
            onPressed: () => Navigator.pop(context),
          ),
          title: Align(
            child: Text(AppLocalizations.of(context)?.detail ?? ''),
            alignment: Alignment.centerLeft,
          ),
          actions: [FavoriteWidget(DetailViewModel(), id)],
          bottom: TabBar(
            unselectedLabelColor: Color(0xFFFFFFFF),
            indicatorColor: Color(0xFFFFFFFF),
            labelColor: Colors.white,
            tabs: [
              Tab(
                child: Text(
                  AppLocalizations.of(context)?.overview ?? '',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Tab(
                child: Text(
                  AppLocalizations.of(context)?.ingredient ?? '',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Tab(
                child: Text(
                  AppLocalizations.of(context)?.instruction ?? '',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            OverViewScreen(OverviewViewModel(RecipesDetailRequest()), id),
            IngredientScreen(IngredientViewModel(IngredientRequest()), id),
            InstructionScreen(InstructionViewModel(InstructionRequest()), id),
          ],
        ),
      ),
    );
  }
}

class FavoriteWidget extends StatefulWidget {
  final DetailViewModel detailViewModel;
  final int id;

  FavoriteWidget(this.detailViewModel, this.id);

  @override
  _FavoriteWidgetState createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  void showSnackBar(BuildContext context) {
    if (widget.detailViewModel.isFavorite.value) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          margin: EdgeInsets.all(16),
          behavior: SnackBarBehavior.floating,
          duration: Duration(milliseconds: 1000),
          content: Text(AppLocalizations.of(context)?.addSuccess ?? ''),
          action: SnackBarAction(
            onPressed: () {},
            label: 'OKAY',
            textColor: Color(0xFFa255ff),
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          margin: EdgeInsets.all(16),
          behavior: SnackBarBehavior.floating,
          duration: Duration(milliseconds: 1000),
          content: Text(AppLocalizations.of(context)?.removeSuccess ?? ''),
          action: SnackBarAction(
            onPressed: () {},
            label: 'OKAY',
            textColor: Color(0xFFa255ff),
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    widget.detailViewModel.checkFavoriteState(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: widget.detailViewModel.isFavorite,
        builder: (context, snapshot) {
          return IconButton(
            onPressed: () {
              widget.detailViewModel.changeFavourite(context, widget.id);
              showSnackBar(context);
            },
            icon: snapshot.data ?? false
                ? Icon(
                    Icons.star,
                    color: Color(0xFFffdd00),
                    size: 20,
                  )
                : Icon(
                    Icons.star,
                    color: Color(0xFFFFFFFF),
                    size: 20,
                  ),
          );
        });
  }
}
