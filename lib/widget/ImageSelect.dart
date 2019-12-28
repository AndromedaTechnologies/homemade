import 'dart:io';

import 'package:flutter/material.dart';
import 'package:homemade/res/color.dart';
import 'package:homemade/res/textStyle.dart';
import 'package:image_picker/image_picker.dart';
import 'package:transparent_image/transparent_image.dart';

class ImageSelect extends StatefulWidget {
  final File file;
  final Function callBackFunction;

  ImageSelect(this.file, this.callBackFunction);

  @override
  _ImageSelectState createState() => _ImageSelectState();
}

class _ImageSelectState extends State<ImageSelect> {
  File file;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    file = widget.file;
  }

  @override
  Widget build(BuildContext context) {
    double widthHeight = 65;
    return InkWell(
      onTap: _loadImage,
      child: file != null
          ? Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(200),
                  child: FadeInImage(
                      placeholder: MemoryImage(kTransparentImage),
                      fit: BoxFit.cover,
                      width: widthHeight,
                      height: widthHeight,
                      image: FileImage(file)),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Update Image",
                  style: TextStyles.textStyleNormalSemiBold(fontSize: 20).apply(
                      decoration:
                          TextDecoration.combine([TextDecoration.underline])),
                ),
              ],
            )
          : Row(
              children: <Widget>[
                Container(
                  width: widthHeight,
                  height: widthHeight,
                  decoration: BoxDecoration(
                      color: MColor.application, shape: BoxShape.circle),
                  child: Center(
                    child: Icon(
                      Icons.camera,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Select Image",
                  style:
                      TextStyles.textStyleNormalDarkGreySemiBold(fontSize: 20)
                          .apply(
                              decoration: TextDecoration.combine(
                                  [TextDecoration.underline])),
                ),
              ],
            ),
    );
  }

  _loadImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      file = image;
      widget.callBackFunction(image);
      setState(() {});
    }
  }
}
