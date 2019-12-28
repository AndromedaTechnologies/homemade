
import 'package:flutter/material.dart';
import 'package:homemade/res/textStyle.dart';

class NotificationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Notification",
        style: TextStyles.textStyleBold(),
      ),
    );
  }
}
