

class NavigationBar {
  String imageUrl, text;
  Function onTap;
  bool selected;

  NavigationBar({this.imageUrl, this.text="", this.onTap, this.selected});

  setOnTab(Function function) {
    onTap = function;
  }
}
