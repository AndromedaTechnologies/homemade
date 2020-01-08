import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homemade/res/color.dart';
import 'package:homemade/res/size.dart';
import 'package:homemade/res/textStyle.dart';

class DropDownItem extends StatefulWidget {
  dynamic product;
  State state;
  double widthInPercentage;

  DropDownItem({this.product, this.state,this.widthInPercentage});

  @override
  _DropDownItemState createState() => _DropDownItemState();
}

class _DropDownItemState extends State<DropDownItem> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        widget.product.selected = !widget.product.selected;
        setState(() {});

        widget.state.setState(() {});
      },
      child: Row(
        children: <Widget>[
          Container(
              width: MySize.of(context).fitWidth(widget.widthInPercentage??75),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              color: widget.product.selected
                  ? MColor.lightGreyB6.withOpacity(0.6)
                  : null,
              child: Text(
                widget.product.text,
                style: TextStyles.textStyleNormalDarkGrey(),
              )),
        ],
      ),
    );
  }
}