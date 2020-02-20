import 'package:flutter/material.dart';
import 'package:homemade/model/UserModel.dart';
import 'package:homemade/model/dishModel.dart';
import 'package:homemade/res/color.dart';
import 'package:homemade/res/imagestring.dart';
import 'package:homemade/res/textStyle.dart';
import 'package:transparent_image/transparent_image.dart';

class DishItem extends StatelessWidget {
  final DishModel dish;
  final Function onTap;

  const DishItem({Key key, this.dish,this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: MColor.lightGreyB6),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[300],
                  offset: Offset(0, 2),
                  blurRadius: 8,
                  spreadRadius: 0)
            ]),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: 160,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Hero(
                      tag: "mydish_hero" + dish?.id??"",
                      child: FadeInImage(
                          placeholder: MemoryImage(kTransparentImage),
                          fit: BoxFit.cover,
                          height: 160,
                          image: (dish?.dishimages?.length??0) > 0
                              ? NetworkImage(dish.dishimages[0].image)
                              : AssetImage(notAvailableImage)),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Image.asset(
                                starImage,
                                height: 20,
                                width: 20,
                                fit: BoxFit.contain,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "5.0",
                                style:
                                TextStyles.textStyleStarBold(fontSize: 16),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "(2)",
                                style:
                                TextStyles.textStyleBoldGrey(fontSize: 16),
                              ),
                              Spacer(),
                              Image.asset(
                                heartBorderImage,
                                height: 30,
                                width: 30,
                                fit: BoxFit.contain,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            dish?.name??"",
                            style: TextStyles.textStyleNormalDarkGreySemiBold(
                                fontSize: 14),
                          ),
                          Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                "\$ ${dish?.price??""}",
                                style:
                                TextStyles.textStyleHardBold(fontSize: 16),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
