
import 'package:homemade/model/dishModel.dart';

class DishStreamState{}

class DataFetchedState extends  DishStreamState {
  List<DishModel> listDishes;
  DishModel dish;

  DataFetchedState({this.listDishes,this.dish});

   bool get hasData => (listDishes?.length??0)>0;

   bool get notNull => dish!=null;

}

class DataLoadingState extends  DishStreamState {}


class ErrorState extends  DishStreamState {}
