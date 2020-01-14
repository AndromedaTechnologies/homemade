import 'package:flutter/material.dart';
import 'package:homemade/res/color.dart';
import 'package:homemade/res/size.dart';
import 'package:homemade/res/textStyle.dart';
import 'package:homemade/widget/errorMessage.dart';

import 'PopupMultiInputDialog.dart';

class PopupTextField extends StatelessWidget {
  final bool isUpdate;
  final bool showEditButton;
  final String labelDialog;
  final String labelTextField;

  final List<String> dataList;
  final Function popDialog;
  final Function deleteFun;

  final bool hasError;
  final String errorText;

  PopupTextField(
      {this.isUpdate,
      this.showEditButton,
      this.labelDialog,
      this.labelTextField,
      this.dataList,
      this.popDialog,
      this.deleteFun,
      this.hasError = false,
      this.errorText = ""});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        InkWell(
          onTap: (isUpdate ? !showEditButton : true)
              ? () {
                  _alertDialog(context);
                }
              : null,
          child: Container(
            width: MySize.of(context).fitWidth(80),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: MColor.lightGreyB6, width: 1))),
            padding: EdgeInsets.only(bottom: 5),
            child: Stack(
              children: <Widget>[
                Center(
                  child: Container(
//                      color:Colors.red,
                    padding: EdgeInsets.only(right: 18, top: 5),
                    width: MySize.of(context).fitWidth(80),
                    child: Wrap(
                        spacing: 4,
                        children: dataListWidget().length > 0
                            ? dataListWidget()
                            : [
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
//                          "Awards and Certification".toUpperCase(),
                                    labelTextField.toUpperCase(),
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
        ),
        Row(
          children: <Widget>[
            hasError
                ? Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: ErrorMessage(errorText))
                : Container()
          ],
        )
      ],
    );
  }

  List<Widget> dataListWidget() {
    return dataList.map((str) => _chip(str)).toList();
  }

  Widget _chip(String text) {
    return InputChip(
      label: Text(
        text,
        style: TextStyles.textStyleNormalWhite(fontSize: 14),
      ),
      backgroundColor: MColor.application,
      disabledColor: MColor.application,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      deleteIcon: Icon(
        Icons.clear,
        size: 16,
        color: Colors.white,
      ),
      onDeleted: deleteFun == null
          ? null
          : () {
              deleteFun(text);
            },
    );
  }

  _alertDialog(context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return PopupMultiInputDialog(dataList, popDialog, labelDialog);
        });
  }
}
