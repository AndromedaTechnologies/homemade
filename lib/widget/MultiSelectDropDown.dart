import 'package:flutter/material.dart';
import 'package:homemade/dropdownClass/cuisine.dart';
import 'package:homemade/res/color.dart';
import 'package:homemade/res/size.dart';
import 'package:homemade/res/textStyle.dart';
import 'package:homemade/widget/errorMessage.dart';

import 'MultSelectDropDownItem.dart';

class MultiSelectDropDown extends StatefulWidget {
  final bool isUpdate;
  final bool showEditButton;
  final String label;
  final dynamic productList;
  final Function okayButton;

  final bool hasError;
  final String errorText;

  MultiSelectDropDown(
      {this.isUpdate,
      this.showEditButton,
      this.label,
      this.productList,
      this.okayButton,
      this.hasError = false,
      this.errorText = ""});

  @override
  _MultiSelectDropDownState createState() => _MultiSelectDropDownState();
}

class _MultiSelectDropDownState extends State<MultiSelectDropDown> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: MySize.of(context).fitWidth(80),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: MColor.lightGreyB6, width: 1))),
          child: Stack(
            children: <Widget>[
              DropdownButton<dynamic>(
                  value: null,
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: MColor.lightGreyB6,
                  ),
                  iconSize: 24,
                  elevation: 0,
                  isExpanded: true,
                  underline: Container(),
                  onChanged: (widget.isUpdate ? !widget.showEditButton : true)
                      ? (_) {
//                              List<String> split =
//                              techDropDownSelectedValue.split(',');
//                              split.contains(index);
                          setState(() {});
                        }
                      : null,
                  hint: Text(""),
                  items: widget.productList
                      .map<DropdownMenuItem<dynamic>>((dynamic value) {
                    return DropdownMenuItem<dynamic>(
                        value: value.text,
                        child: DropDownItem(
                          product: value,
                          state: this,
                        ));
                  }).toList()
                        ..add(DropdownMenuItem<dynamic>(
                            value: "other", child: _okayButton()))),
              Center(
                child: Container(
//                      color:Colors.red,
                  padding: EdgeInsets.only(right: 18, top: 5),
                  width: MySize.of(context).fitWidth(80),
                  child: Wrap(
                      spacing: 4,
                      children: selectedProducts().length > 0
                          ? selectedProducts()
                          : [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  widget.label.toUpperCase(),
                                  style: TextStyles.textStyleBold(
                                      fontSize: 16, spacing: 4.0),
                                ),
                              ),
                            ]),
                ),
              ),
            ],
          ),
        ),

        Row(
          children: <Widget>[
            widget.hasError
                ? Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: ErrorMessage(widget.errorText))
                : Container()
          ],
        )      ],
    );
  }

  Widget _okayButton() {
    return widget.okayButton != null
        ? Row(
            children: <Widget>[
              Spacer(),
              FlatButton(
                  onPressed: widget.okayButton,
                  color: MColor.application,
                  child: Text(
                    "Done".toUpperCase(),
                    style: TextStyles.textStyleBoldWhite(
                        fontSize: 16, spacing: 0.4),
                  ))
            ],
          )
        : Container();
  }

  List<Widget> selectedProducts() {
    List<dynamic> productListSelected = [];

    widget.productList.forEach((product) {
      if (product.selected) productListSelected.add(product);
    });
    return productListSelected.map((dynamic product) {
      return _chipProduct(product);
    }).toList();
  }

  Widget _chipProduct(dynamic product) {
    print(product);
    return InputChip(
      label: Text(
        product.text,
        style: TextStyles.textStyleNormalWhite(fontSize: 14),
      ),
      backgroundColor: MColor.application,
      disabledColor: MColor.application,
      isEnabled: true,
      labelStyle: TextStyles.textStyleNormalWhite(fontSize: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      deleteIcon: Icon(
        Icons.clear,
        size: 16,
        color: Colors.white,
      ),
      onDeleted: (widget.isUpdate ? !widget.showEditButton : true)
          ? () {
              product.selected = !product.selected;
              setState(() {});
            }
          : null,
    );
  }
}
