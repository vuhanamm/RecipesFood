import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_pilot/Helper/Config/app_color.dart';
import 'package:project_pilot/Helper/Config/app_text_style.dart';
import 'package:project_pilot/View/Screens/DetailScreens/detail.dart';
import 'package:project_pilot/model/recipes.dart';
import 'package:project_pilot/view/widget/chip_filter_widget.dart';
import 'package:project_pilot/view/widget/recipes_item.dart';
import 'package:project_pilot/viewmodel/detail_view_model.dart';
import 'package:project_pilot/viewmodel/recipes_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RecipesScreen extends StatefulWidget {
  final RecipesViewModel recipesViewModel;

  RecipesScreen(this.recipesViewModel);

  @override
  _RecipesScreenState createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
  @override
  void initState() {
    super.initState();
    widget.recipesViewModel.getRecipes();
    widget.recipesViewModel.searchRecipes();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width / 100;
    double h = MediaQuery.of(context).size.height / 100;
    return Scaffold(
      appBar: buildAppBar(),
      floatingActionButton: myFloatingButton(),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          StreamBuilder<bool>(
              initialData: true,
              stream: widget.recipesViewModel.hasInternetConnection,
              builder: (context, snapshot) {
                bool hasInternet = snapshot.data ?? false;
                return hasInternet
                    ? Container()
                    : Container(
                        color: Theme.of(context).primaryColor,
                        width: 100 * w,
                        height: 15 * h,
                        decoration: BoxDecoration(),
                        margin: EdgeInsets.all(16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.signal_wifi_off,
                                  size: 40,
                                  color: AppColor.purplishBlue,
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Container(
                                  child: Text(
                                    AppLocalizations.of(context)
                                            ?.networkProblem ??
                                        '',
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                )
                              ],
                            ),
                            Container(
                              width: 100 * w,
                              margin: EdgeInsets.symmetric(horizontal: 16),
                              alignment: Alignment.bottomRight,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: () {},
                                    child: Text(
                                        AppLocalizations.of(context)?.dismiss ??
                                            ''),
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    child: Text(AppLocalizations.of(context)
                                            ?.turnOnWifi ??
                                        ''),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
              }),
          Expanded(
            child: StreamBuilder<List<Recipes>>(
              initialData: [],
              stream: widget.recipesViewModel.listRecipesSubject,
              builder:
                  (BuildContext context, AsyncSnapshot<List<Recipes>> snap) {
                if (snap.connectionState == ConnectionState.active) {
                  if (snap.hasData) {
                    List<Recipes> listData = snap.data ?? [];
                    if (listData.isEmpty) {
                      return Center(
                        child: Text(
                          AppLocalizations.of(context)?.noRecipes ?? "",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      );
                    } else {
                      return listViewShowRecipes(listData);
                    }
                  } else if (snap.hasError) {
                    var err = snap.error;
                    if(err == 'No Internet'){
                      return Center(
                        child: Image.asset('assets/images/no_internet_connection1.png'),
                      );
                    }
                    return Center(
                      child: Text(
                        AppLocalizations.of(context)?.hasError ?? "",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                } else if (snap.connectionState == ConnectionState.waiting) {
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
          ),
        ],
      ),
    );
  }

  Widget myFloatingButton() {
    return GestureDetector(
      child: Image.asset('assets/images/floating_action_button.png'),
      onTap: () => showModalBottomSheet(
        context: context,
        builder: (context) => filterWidget2(),
      ),
      behavior: HitTestBehavior.translucent,
    );
  }

  ListView listViewShowRecipes(List<Recipes> listData) {
    return ListView.builder(
        itemCount: listData.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            child: ItemFood(listData[index]),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    DetailScreen(listData[index].id ?? 0, DetailViewModel()),
              ),
            ),
          );
        });
  }

  //Filter khi click filter trên ActionBar
  Container filterWidget() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Icon(Icons.filter_list),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  AppLocalizations.of(context)?.filters ?? "",
                  style: Theme.of(context).textTheme.headline6?.copyWith(
                        fontSize: 20,
                        fontFamily: 'Roboto-Medium',
                      ),
                ),
              ),
            ],
          ),
          ChipFilterWidget(
            length: 6,
            subject: widget.recipesViewModel.indexOfFilterSubject,
            listData: widget.recipesViewModel.listFilter1,
            changeSelectedItem: widget.recipesViewModel.setCheckedFilter,
            isShowIcon: false,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: AppColor.purplishBlue,
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: () {
                widget.recipesViewModel.sortFilter();
                Navigator.pop(context);
              },
              child: Text(
                AppLocalizations.of(context)?.apply ?? "",
                style: Theme.of(context).textTheme.headline6?.copyWith(
                      fontSize: 16,
                      color: Color(0xFFFFFFFF),
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //filter khi click FloatingButton:
  Container filterWidget2() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              AppLocalizations.of(context)?.mealType ?? "",
              style: Theme.of(context).textTheme.headline6?.copyWith(
                    fontSize: 20,
                    fontFamily: 'Roboto-Medium',
                  ),
            ),
          ),
          ChipFilterWidget(
            length: 7,
            subject: widget.recipesViewModel.indexOfFilterByMealSubject,
            listData: widget.recipesViewModel.listFilterByMealType,
            changeSelectedItem: widget.recipesViewModel.setCheckedFilterByMeal,
            isShowIcon: true,
          ),
          SizedBox(height: 20),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              AppLocalizations.of(context)?.dietType ?? "",
              style: Theme.of(context).textTheme.headline6?.copyWith(
                    fontSize: 20,
                    fontFamily: 'Roboto-Medium',
                  ),
            ),
          ),
          ChipFilterWidget(
            length: 7,
            subject: widget.recipesViewModel.indexOfFilterByDietSubject,
            listData: widget.recipesViewModel.listFilterByDietType,
            changeSelectedItem: widget.recipesViewModel.setCheckedFilterByDiet,
            isShowIcon: true,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: AppColor.purplishBlue,
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: () => {
                widget.recipesViewModel.getRecipesByTypeAndDiet(),
                Navigator.pop(context)
              },
              child: Text(
                AppLocalizations.of(context)?.apply ?? '',
                style: Theme.of(context).textTheme.headline6?.copyWith(
                      fontSize: 16,
                      color: Color(0xFFFFFFFF),
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return widget.recipesViewModel.isShowSearchEdt.value
        ? AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                setState(() {
                  widget.recipesViewModel.setShowSearchEdt();
                });
              },
              color: Color(0x61000000),
            ),
            title: searchEdt(),
          )
        : AppBar(
            title: Align(
              alignment: Alignment.centerLeft,
              child: Text(AppLocalizations.of(context)?.recipes ?? ''),
            ),
            actions: [
              actionCustom(),
            ],
          );
  }

  Container searchEdt() {
    return Container(
      color: Colors.white,
      child: TextField(
          decoration: InputDecoration(
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: Icon(Icons.keyboard_voice),
              onPressed: () {},
              color: Color(0x61000000),
            ),
            hintText: AppLocalizations.of(context)?.search ?? '',
            hintStyle: AppTextStyle.titleStyle20.copyWith(
              color: Color(0x61000000),
            ),
          ),
          onChanged: (value) {
            widget.recipesViewModel.addValue(value);
          },
          onSubmitted: (value) {
            widget.recipesViewModel.getRecipes(query: value);
            widget.recipesViewModel.setShowSearchEdt();
          }),
    );
  }

  Row actionCustom() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () {
            widget.recipesViewModel.setShowSearchEdt();
            setState(() {});
          },
          icon: Icon(Icons.search),
        ),
        IconButton(
          onPressed: () => showModalBottomSheet(
            context: context,
            builder: (context) => filterWidget(),
          ),
          icon: Icon(Icons.filter_list_sharp),
        ),
      ],
    );
  }
}
