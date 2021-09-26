import 'package:flutter/material.dart';
import 'package:project_pilot/Helper/Config/app_color.dart';
import 'package:project_pilot/View/Screens/DetailScreens/detail.dart';
import 'package:project_pilot/model/recipes.dart';
import 'package:project_pilot/view/widget/recipes_item.dart';
import 'package:project_pilot/viewmodel/detail_view_model.dart';
import 'package:project_pilot/ViewModel/favorite_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FavoriteScreen extends StatefulWidget {
  final FavoriteViewModel favoriteViewModel;

  FavoriteScreen(this.favoriteViewModel);

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    super.initState();
    widget.favoriteViewModel.getFavorite();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Container(
        child: StreamBuilder<List<Recipes>>(
            stream: widget.favoriteViewModel.listRecipesSubject,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Recipes> listData = snapshot.data ?? [];
                if (listData.isEmpty) {
                  return Center(
                    child:
                        Image.asset('assets/images/no_internet_connection.png'),
                  );
                }
                return ListView.builder(
                  itemCount: listData.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(
                          listData[index].id ?? 0,
                          DetailViewModel(),
                        ),
                      ),
                    ).then(
                      (value) => widget.favoriteViewModel.getFavorite(),
                    ),
                    onLongPress: () async {
                      widget.favoriteViewModel.addId(listData[index].id ?? 0);
                      widget.favoriteViewModel.showAppBar();
                      setState(() {});
                    },
                    child: Stack(
                      children: [
                        ItemFood(
                          listData[index],
                        ),
                        Container(
                          constraints: BoxConstraints(
                            minHeight: 218,
                            minWidth: double.infinity,
                          ),
                          margin:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: widget.favoriteViewModel.setID
                                    .contains(listData[index].id)
                                ? Color(0x1a651fff)
                                : null,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            border: Border.all(
                              color: widget.favoriteViewModel.setID
                                      .contains(listData[index].id)
                                  ? Color(0xFF651fff)
                                  : Color(0x00FFFFFF),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return Center(
                  child: Text(AppLocalizations.of(context)?.hasError ?? ''),
                );
              }
            }),
      ),
    );
  }

  AppBar buildAppBar() {
    return !widget.favoriteViewModel.isShowAppBar.value
        ? AppBar(
            title: Align(
              alignment: Alignment.centerLeft,
              child: Text(AppLocalizations.of(context)?.favoriteRecipes ?? ''),
            ),
            actions: [
              showPopupMenu(),
            ],
          )
        : AppBar(
            backgroundColor: Colors.black,
            leading: IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                widget.favoriteViewModel.closeAppBar();
                setState(() {});
              },
            ),
            title: Text(
              '${widget.favoriteViewModel.setID.length} ${AppLocalizations.of(context)?.itemSelected ?? ''}',
            ),
            actions: [
              IconButton(
                onPressed: () async {
                  await widget.favoriteViewModel.deleteByID();
                  showSnackBar();
                  setState(() {});
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
            ],
          );
  }

  PopupMenuButton showPopupMenu() {
    return PopupMenuButton(
      icon: Icon(Icons.more_vert),
      itemBuilder: (context) => [
        PopupMenuItem(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text(
                  AppLocalizations.of(context)?.deleteAllQ ?? "",
                  style: Theme.of(context).textTheme.headline6?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                ),
                content: Text(
                  AppLocalizations.of(context)?.deleteAllFavorite ?? "",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(fontSize: 14),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: Text(
                      AppLocalizations.of(context)?.cancel ?? "",
                      style: TextStyle(
                        color: AppColor.purplishBlue,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      await widget.favoriteViewModel.deleteAlLFavorite(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                      showSnackBar();
                    },
                    child: Text(
                      AppLocalizations.of(context)?.yes ?? "",
                      style: TextStyle(
                        color: AppColor.purplishBlue,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            child: Text(
              AppLocalizations.of(context)?.deleteAll ?? "",
            ),
          ),
        )
      ],
    );
  }

  void showSnackBar() {
    if (widget.favoriteViewModel.isDeleted.value) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)?.deleteSuccess ?? ''),
          action: SnackBarAction(label: 'Ok', onPressed: () {}),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)?.deleteFail ?? ''),
          action: SnackBarAction(label: 'Ok', onPressed: () {}),
        ),
      );
    }
  }
}
