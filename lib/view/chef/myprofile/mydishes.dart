import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homemade/model/dishModel.dart';
import 'package:homemade/res/color.dart';
import 'package:homemade/res/imagestring.dart';
import 'package:homemade/res/textStyle.dart';
import 'package:homemade/stream/dish/event.dart';
import 'package:homemade/stream/dish/state.dart';
import 'package:homemade/stream/dish/stream.dart';
import 'package:homemade/widget/loading.dart';
import 'package:shimmer/shimmer.dart';
import 'package:transparent_image/transparent_image.dart';

class MyDishesView extends StatefulWidget {
  @override
  _MyDishesViewState createState() => _MyDishesViewState();
}

class _MyDishesViewState extends State<MyDishesView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  DishStream stream;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    stream = DishStream(_scaffoldKey);
    stream.dispatch(FetchMultipleData());

    Future.delayed(Duration.zero, () {
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: stream.dishStream,
        builder: (context, snapshot) {

          var dishState = snapshot.data;

          if (snapshot.hasError || dishState is ErrorState) {
            return Center(child: Text("Error while Processing Request"));
          }

          print(dishState);
          if (!snapshot.hasData || dishState is DataLoadingState) {
//          if (true) {
            return shimmerWidget();
          }

          if (dishState is DataFetchedState) {
            if (!dishState.hasData) {
              return Center(child: Text("No Data Found"));
            }
          }

          return ListView.builder(
              itemCount: dishState.listDishes.length,
              itemBuilder: (context, index) {
                return dishWidget(dishState.listDishes[index]);
              });
        });
  }

  Widget dishWidget(DishModel dish) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: MColor.lightGreyB6),
          boxShadow: [
            BoxShadow(
                color: MColor.lightGreyB6,
                offset: Offset(0, 2),
                blurRadius: 3,
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
                  child: FadeInImage(
                      placeholder: MemoryImage(kTransparentImage),
                      fit: BoxFit.cover,
                      height: 160,
                      image: dish.dishimages.length > 0
                          ? NetworkImage(dish.dishimages[0].image)
                          : AssetImage(notAvailableImage)),
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
                              style: TextStyles.textStyleStarBold(fontSize: 16),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "(2)",
                              style: TextStyles.textStyleBoldGrey(fontSize: 16),
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
                          dish.description,
                          style: TextStyles.textStyleNormalDarkGreySemiBold(
                              fontSize: 14),
                        ),
                        Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              "\$ ${dish.price}",
                              style: TextStyles.textStyleHardBold(fontSize: 16),
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
    );
  }

  Widget shimmerWidget(){
    Color baseColor = Colors.grey[300];
    Color highlightColor = Colors.grey[100];
    return ListView.builder(itemCount: 4,itemBuilder: (context,index){
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: MColor.lightGreyB6),
            boxShadow: [
              BoxShadow(
                  color: MColor.lightGreyB6,
                  offset: Offset(0, 2),
                  blurRadius: 3,
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
                    child: Shimmer.fromColors(
                      baseColor: baseColor,
                      highlightColor: highlightColor,
                      child: Container(
                        width: double.infinity,
                        color: Colors.white,
                        height: double.infinity,
                      ),
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
                              Shimmer.fromColors(
                                baseColor: baseColor,
                                highlightColor: highlightColor,
                                child: Image.asset(
                                  starImage,
                                  height: 20,
                                  width: 20,
                                  fit: BoxFit.contain,
                                ),
                              ),


                              SizedBox(
                                width: 5,
                              ),
                              Shimmer.fromColors(
                                baseColor: baseColor,
                                highlightColor: highlightColor,
                                child: Text(
                                  "5.0",
                                  style: TextStyles.textStyleStarBold(fontSize: 16),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Shimmer.fromColors(
                                baseColor: baseColor,
                                highlightColor: highlightColor,
                                child: Text(
                                  "(0)",
                                  style: TextStyles.textStyleBoldGrey(fontSize: 16),
                                ),
                              ),
                              Spacer(),
                              Shimmer.fromColors(
                                baseColor: baseColor,
                                highlightColor: highlightColor,
                                child: Image.asset(
                                  heartBorderImage,
                                  height: 30,
                                  width: 30,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Shimmer.fromColors(
                            baseColor: baseColor,
                            highlightColor: highlightColor,
                            child: Text(
                              "                ",
                              style: TextStyles.textStyleNormalDarkGreySemiBold(
                                  fontSize: 14),
                            ),
                          ),
                          Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Shimmer.fromColors(
                                baseColor: baseColor,
                                highlightColor: highlightColor,
                                child: Text(
                                  "\$ 000",
                                  style: TextStyles.textStyleHardBold(fontSize: 16),
                                ),
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
      );
    });
  }
}
