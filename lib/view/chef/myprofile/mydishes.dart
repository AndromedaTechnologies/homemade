import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homemade/res/color.dart';
import 'package:homemade/res/imagestring.dart';
import 'package:homemade/res/textStyle.dart';
import 'package:transparent_image/transparent_image.dart';

class MyDishesView extends StatefulWidget {
  @override
  _MyDishesViewState createState() => _MyDishesViewState();
}

class _MyDishesViewState extends State<MyDishesView> {


  @override
  Widget build(BuildContext context){
//    return StreamBuilder(stream: ,builder: (context,snapsnot){})
  }

  Widget test(BuildContext context) {
    return ListView.builder(
        itemCount: 8,
        padding: EdgeInsets.symmetric(vertical: 10),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (context, index) {
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
                            image: AssetImage(foodImage)),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
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

                              SizedBox(height: 10,),
                              Text("Best of the Best",style: TextStyles.textStyleNormalDarkGreySemiBold(fontSize: 14),),

                              Spacer(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                Text("\$ 200",style: TextStyles.textStyleHardBold(fontSize: 16),),
                              ],),


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
