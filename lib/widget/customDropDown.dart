import 'package:flutter/material.dart';
import 'package:homemade/res/color.dart';
import 'package:homemade/res/textStyle.dart';

import 'errorMessage.dart';

class CustomDropDown extends StatefulWidget {
  final dynamic selectedValue;
  final List listData;
  final Function onChangeFun;
  final double width;
  final String hintText;
  final bool hasError;
  final String errorText;

  CustomDropDown({
    @required this.selectedValue,
    @required this.listData,
    this.onChangeFun,
    this.hintText,
    this.width,
    this.hasError = false,
    this.errorText = "",
  });

  @override
  _CustomDropDownState createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print(
        "Selected Value ${widget.selectedValue} and List Values ${widget.listData}");
    try {
      return Column(
        children: <Widget>[
          Container(
            height: 50,
            width: widget.width ?? double.infinity,
//            padding: EdgeInsets.symmetric(
//                horizontal: size.width * .03),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: MColor.lightGreyB6, width: 1.3))),

            child: DropdownButton<dynamic>(
              value: widget.selectedValue?.toString(),
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: MColor.lightGreyB6,
              ),
              iconSize: 24,
              elevation: 0,
              hint: Text(
                widget?.hintText?.toUpperCase() ?? "",
                style: TextStyles.textStyleBold(fontSize: 16, spacing: 4.0),
              ),
              isExpanded: true,
              style: TextStyles.textStyleNormalGrey(fontSize: 16),
              underline: Container(),
              onChanged: widget.onChangeFun,
              items: widget.listData
                  .map<DropdownMenuItem<dynamic>>((dynamic value) {
                return DropdownMenuItem<dynamic>(
                  value: value.toString(),
                  child: Text(
                    value.toString(),
                    style: TextStyles.textStyleNormalGrey(fontSize: 16),
                  ),
                );
              }).toList(),
            ),
          ),
          Row(
            children: <Widget>[
              widget.hasError
                  ? Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: ErrorMessage(widget.errorText))
                  : Container(),
            ],
          )
        ],
      );
    } catch (e) {
      print(
          "Dropdown Error $e ${widget.selectedValue} contain ${widget.listData.map((item) => item == widget.selectedValue)}");
      return Text("Error While loading DropDown");
    }
  }
}
