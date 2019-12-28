
class UserModel{


  static String getInitials(String firstName, String lastName) {
    String nameFirst = "";
    String nameLast = "";
    try {
      nameFirst = firstName.substring(0, 1).toUpperCase();
    } catch (e) {}

    try {
      nameLast = lastName.substring(0, 1).toUpperCase();
    } catch (e) {
      nameLast = ".";
    }

    return nameFirst + nameLast;
  }

}