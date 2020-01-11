class DishEvent {}

class FetchMultipleData extends DishEvent {}

class FetchSingleData extends DishEvent {
  String id;
  FetchSingleData({this.id});
}
