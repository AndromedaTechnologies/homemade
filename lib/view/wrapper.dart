
import 'package:flutter/material.dart';
import 'package:homemade/model/UserLoginModel.dart';
import 'package:homemade/stream/UserProvider.dart';
import 'package:homemade/stream/UserProviderInstance.dart';
import 'package:homemade/stream/notifier.dart';
import 'package:homemade/view/pageselection.dart';
import 'package:provider/provider.dart';

class WrapperStream extends StatefulWidget {
  @override
  _WrapperStreamState createState() => _WrapperStreamState();
}

class _WrapperStreamState extends State<WrapperStream> {
  UserProvider userProviderInstance = UserInstance.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    await userProviderInstance.dispatch(GetUserData());
  }

  @override
  Widget build(BuildContext context) {
    print("WrapperStream WrapperStream");

    return StreamProvider<UserStreamModel>.value(
      value: userProviderInstance.status,
      child: PageSelection(),
    );
  }
}
