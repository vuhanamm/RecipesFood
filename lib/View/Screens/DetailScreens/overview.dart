import 'package:flutter/material.dart';
import 'package:project_pilot/Helper/Config/app_color.dart';
import 'package:project_pilot/Helper/Config/app_text_style.dart';
import 'package:project_pilot/model/recipes_overview.dart';
import 'package:project_pilot/viewmodel/overview_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OverViewScreen extends StatefulWidget {
  final OverviewViewModel overviewViewModel;
  final int id;

  OverViewScreen(this.overviewViewModel, this.id);

  @override
  _OverViewScreenState createState() => _OverViewScreenState();
}

class _OverViewScreenState extends State<OverViewScreen> {
  @override
  void initState() {
    super.initState();
    widget.overviewViewModel.getRecipesOverview(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    widget.overviewViewModel.getRecipesOverview(widget.id);
    double w = MediaQuery.of(context).size.width / 100;
    double h = MediaQuery.of(context).size.height / 100;
    return StreamBuilder<RecipesOverview>(
        stream: widget.overviewViewModel.recipesSubject,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              final data = snapshot.data;
              if (data != null) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      imageOverview(h, w),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        child: Text(
                          '${data.title}',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            typeCheck(
                              data.isVegan ?? false,
                              AppLocalizations.of(context)?.vegan ?? '',
                            ),
                            typeCheck(
                              data.isDairyFree ?? false,
                              AppLocalizations.of(context)?.dairyFree ?? '',
                            ),
                            typeCheck(
                              data.isHealthy ?? false,
                              AppLocalizations.of(context)?.healthy ?? '',
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            typeCheck(
                              data.isVegetarian ?? false,
                              AppLocalizations.of(context)?.vegetarian ?? '',
                            ),
                            typeCheck(
                              data.isGlutenFree ?? false,
                              AppLocalizations.of(context)?.glutenFree ?? '',
                            ),
                            typeCheck(
                              data.isCheap ?? false,
                              AppLocalizations.of(context)?.cheap ?? '',
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                        child: Text(
                          AppLocalizations.of(context)?.description ?? '',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(fontSize: 12),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, bottom: 16),
                        child: Text(
                          data.description ?? '',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(
                                  fontSize: 16, fontFamily: 'Roboto-Medium'),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Center(
                  child: Text(
                    AppLocalizations.of(context)?.noData ?? '',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                );
              }
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
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Stack imageOverview(double h, double w) {
    return Stack(
      children: [
        Container(
          height: 30 * h,
          width: 100 * w,
          child: Image.network(
            '${widget.overviewViewModel.recipesSubject.value.imageUrl}',
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: 8,
          right: 8,
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.only(left: 16, top: 8, bottom: 8, right: 8),
                child: Column(
                  children: [
                    Icon(
                      Icons.favorite,
                      color: Color(0xFFFFFFFF),
                    ),
                    Text(
                      '${widget.overviewViewModel.recipesSubject.value.likesNumber}',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 14,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 8, top: 8, bottom: 8, right: 8),
                child: Column(
                  children: [
                    Icon(
                      Icons.access_time,
                      color: Color(0xFFFFFFFF),
                    ),
                    Text(
                      '${widget.overviewViewModel.recipesSubject.value.readyInMinutes}',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 14,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget typeCheck(bool check, String value) {
    return Expanded(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.check_circle,
            color: check ? AppColor.shamrockGreen : AppColor.black38p,
            size: 24,
          ),
          SizedBox(
            width: 8,
          ),
          Text(
            '$value',
            style: AppTextStyle.descriptionStyle.copyWith(
                color: check ? AppColor.shamrockGreen : AppColor.black38p),
          ),
        ],
      ),
    );
  }
}
