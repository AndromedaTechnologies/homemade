

import 'UserProvider.dart';

class UserInstance{

  ///userProvider [logout] must initialized to null
  static UserProvider userProvider;

  static UserProvider get instance{
    if(userProvider==null){
      userProvider = UserProvider();
      return userProvider;
    }else{
      return userProvider;
    }
  }
}