
import 'package:flutter/material.dart';
import 'package:homemade/res/color.dart';
import 'package:homemade/res/textStyle.dart';
import 'package:homemade/widget/TextFieldWIthImage.dart';

class PopupMultiInputDialog extends StatefulWidget {
  final List<String> awardsAndCertificates;
  final Function callBackFunction;
  final String textFieldLabel;

  PopupMultiInputDialog(
      this.awardsAndCertificates, this.callBackFunction, this.textFieldLabel);

  @override
  _AlertDialogAwardAndCertificateState createState() =>
      _AlertDialogAwardAndCertificateState();
}

class _AlertDialogAwardAndCertificateState
    extends State<PopupMultiInputDialog> {
  TextEditingController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.0),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Center(
            child: Container(
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: MColor.lightGreyB6,
                        spreadRadius: 0,
                        blurRadius: 4.0,
                        offset: Offset(0, 3))
                  ]),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _stepperHeading("Awards and Certifications"),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 7,
                        child: TextFieldWithImage(
                          controller: controller,
                          label: widget.textFieldLabel??"",
                          removeImageIcon: true,
                          textInputType: TextInputType.text,
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: FlatButton(
                            onPressed: _addItem,
                            color: MColor.application,
                            child: Text(
                              "Save".toUpperCase(),
                              style: TextStyles.textStyleBoldWhite(
                                  fontSize: 16, spacing: 0.4),
                            )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Wrap(spacing: 4, children: awardsCertifications()),
                  SizedBox(
                    height: 20,
                  ),
                  FlatButton(
                      onPressed: () {
                        widget.callBackFunction(widget.awardsAndCertificates);
                        Navigator.pop(context);
                      },
                      color: MColor.application,
                      child: Text(
                        "Done".toUpperCase(),
                        style: TextStyles.textStyleBoldWhite(
                            fontSize: 16, spacing: 0.4),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> awardsCertifications() {
    return widget.awardsAndCertificates.map((ac) => _chip(ac)).toList();
  }

  Widget _chip(String text) {
    return InputChip(
      label: Text(
        text,
        style: TextStyles.textStyleNormalWhite(fontSize: 14),
      ),
      backgroundColor: MColor.application,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      deleteIcon: Icon(
        Icons.clear,
        size: 16,
        color: Colors.white,
      ),
      onDeleted: () {
        widget.awardsAndCertificates.remove(text);
        setState(() {});
      },
    );
  }

  Widget _stepperHeading(String heading) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 7,
          child: Text(
            heading,
            style: TextStyles.textStyleNormalDarkGreyBold(fontSize: 20),
          ),
        ),
      ],
    );
  }

  ///
  ///
  /// Functions
  ///
  _addItem() {
    print("add");
    if (controller.text != "") {
      print("Add ${controller.text}");
      widget.awardsAndCertificates.add(controller.text);
      controller.clear();
      setState(() {});
    }
  }
}
