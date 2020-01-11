

import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:homemade/model/dishModel.dart';
import 'package:homemade/res/stringapi.dart';
import 'package:homemade/server/GeneralAPI.dart';
import 'package:homemade/stream/dish/event.dart';
import 'package:homemade/stream/dish/state.dart';

class DishStream {
  GlobalKey<ScaffoldState> scaffold;

  final StreamController<DishStreamState> _controller = StreamController<DishStreamState>.broadcast();

  List<DishModel> _listDishes;
  DishModel _dish;

  Stream<DishStreamState> get dishStream => _controller.stream;

  API api;

  DishStream(this.scaffold);

  Future _getDishes() async{
    try{

      _controller.add(DataLoadingState());

      api = API(scaffold);

      Response response  = await api.get(url: CHEF_GET_DISHES_URL);

      if(response!=null && response.data is Map) {
        _listDishes = _getListFromJson(response.data);
      }

      _controller.add(DataFetchedState(listDishes: _listDishes));

    }catch(e){
      _controller.add(ErrorState());
      print(e);
    }
  }

  _getListFromJson(Map<String,dynamic> json){
    List<DishModel>  dishes = [];

    List response = json['dish'];
    response.forEach((jsonData){ dishes.add(DishModel.fromJson(jsonData));});

    return dishes;

  }

  Future _getDish(String id) async{
    try{

      _controller.add(DataLoadingState());

      api = API(scaffold);

      Response response  = await api.get(url: CHEF_DISH_URL+"/$id");

      if(response!=null && response.data is Map) {
        _dish = DishModel.fromJson(response.data);
      }

      _controller.add(DataFetchedState(dish: _dish));

    }catch(e){
      _controller.add(ErrorState());
      print(e);
    }
  }

  void dispatch(DishEvent event){
    if(event is FetchMultipleData){
      _getDishes();
    }
    else
    if(event is FetchSingleData){
      _getDish(event.id);
    }

  }

  void dispose(){
  }



}