import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_pilot/model/recipes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ItemFood extends StatefulWidget {
  final Recipes recipes;

  ItemFood(this.recipes);

  @override
  _ItemFoodState createState() => _ItemFoodState();
}

class _ItemFoodState extends State<ItemFood> {
  void doSomething(int id) {}

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Container(
        child: Row(
          children: [
            Expanded(
              flex: 9,
              child: Container(
                constraints: BoxConstraints(minHeight: 218, minWidth: 182),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10)),
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(
                        '${widget.recipes.imageUrl}',
                      ),
                      fit: BoxFit.cover),
                ),
              ),
            ),
            Expanded(
              flex: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      '${widget.recipes.title}',
                      style: Theme.of(context).textTheme.headline6,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      '${widget.recipes.description}',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              left: 16, top: 8, bottom: 8, right: 8),
                          child: Column(
                            children: [
                              Icon(
                                Icons.favorite,
                                color: Color(0xFFf44336),
                              ),
                              Text(
                                '${widget.recipes.likesNumber}',
                                style: TextStyle(
                                  color: Color(0xFFf44336),
                                  fontSize: 14,
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              left: 8, top: 8, bottom: 8, right: 8),
                          child: Column(
                            children: [
                              Icon(
                                Icons.access_time,
                                color: Color(0xFFff8f00),
                              ),
                              Text(
                                '${widget.recipes.readyInMinutes}',
                                style: TextStyle(
                                  color: Color(0xFFff8f00),
                                  fontSize: 14,
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              left: 8, top: 8, bottom: 8, right: 8),
                          child: Column(
                            children: [
                              Icon(
                                Icons.eco_rounded,
                                color: widget.recipes.isVegan ?? false
                                    ? Color(0xFF00c853)
                                    : Colors.grey.shade400,
                              ),
                              Text(
                                AppLocalizations.of(context)?.vegan ?? '',
                                style: TextStyle(
                                  color: widget.recipes.isVegan ?? false
                                      ? Color(0xFF00c853)
                                      : Colors.grey.shade500,
                                  fontSize: 14,
                                ),
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
