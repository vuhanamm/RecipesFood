import 'package:flutter/material.dart';
import 'package:project_pilot/model/ingredient.dart';
import 'package:project_pilot/viewmodel/ingredient_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class IngredientScreen extends StatefulWidget {
  final int id;
  final IngredientViewModel ingredientViewModel;

  IngredientScreen(this.ingredientViewModel, this.id);

  @override
  _IngredientScreenState createState() => _IngredientScreenState();
}

class _IngredientScreenState extends State<IngredientScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    widget.ingredientViewModel.getIngredient(widget.id);
    double w = MediaQuery.of(context).size.width / 100;
    return Container(
      padding: EdgeInsets.all(20),
      child: StreamBuilder<List<Ingredient>>(
        stream: widget.ingredientViewModel.listIngredientSubject,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              final data = snapshot.data ?? [];
              if (data.isEmpty) {
                return Center(
                  child: Text(
                    AppLocalizations.of(context)?.noData ?? '',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                );
              }
              return Container(
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return itemListView(data, w, index);
                  },
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  AppLocalizations.of(context)?.hasError ?? '',
                  style: Theme.of(context).textTheme.headline6,
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Center(
              child: Text(
                AppLocalizations.of(context)?.hasError ?? '',
                style: Theme.of(context).textTheme.headline6,
              ),
            );
          }
        },
      ),
    );
  }

  Container itemListView(List<Ingredient> data, double w, int index) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Theme.of(context).primaryColor,
        border: Border.all(
          color: Color(0xFFdfdfdf),
        ),
      ),
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 30 * w,
            height: 30 * w,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  '${data[index].imageUrl}',
                ),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
              border: Border.all(
                color: Color(0xFFdfdfdf),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  constraints: BoxConstraints(maxWidth: 50 * w),
                  child: Text(
                    data[index].name ?? "",
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  child: Text(
                    data[index].metric ?? "",
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.copyWith(fontSize: 14),
                  ),
                ),
                Text(
                  AppLocalizations.of(context)?.solid ?? '',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(fontSize: 14),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
