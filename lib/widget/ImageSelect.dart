import 'dart:io';

import 'package:flutter/material.dart';
import 'package:homemade/res/color.dart';
import 'package:homemade/res/textStyle.dart';
import 'package:image_picker/image_picker.dart';
import 'package:transparent_image/transparent_image.dart';

class ImageSelectOrServer extends StatefulWidget {
  final File file;
  final String imageURL;
  final Function callBackFunction;
  final bool enable;
  final String errorMessage;

  ImageSelectOrServer(this.file, this.callBackFunction,
      {this.imageURL, this.enable = true, this.errorMessage});

  @override
  _ImageSelectOrServerState createState() => _ImageSelectOrServerState();
}

class _ImageSelectOrServerState extends State<ImageSelectOrServer> {
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
    return Column(
      children: <Widget>[
        InkWell(
          onTap: widget.enable ? _loadImage : null,
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
              : widget.imageURL != null && widget.imageURL != ""
                  ? Row(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(200),
                          child: FadeInImage(
                              placeholder: MemoryImage(kTransparentImage),
                              fit: BoxFit.cover,
                              width: widthHeight,
                              height: widthHeight,
                              image: NetworkImage(widget.imageURL)),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          "Update Image",
                          style: TextStyles.textStyleNormalSemiBold(fontSize: 20)
                              .apply(
                                  decoration: TextDecoration.combine(
                                      [TextDecoration.underline])),
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
                          style: TextStyles.textStyleNormalDarkGreySemiBold(
                                  fontSize: 20)
                              .apply(
                                  decoration: TextDecoration.combine(
                                      [TextDecoration.underline])),
                        ),
                      ],
                    ),
        ),
        widget.errorMessage==null?Container():Text(widget.errorMessage,style: TextStyles.textStyleError(),)
      ],
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
