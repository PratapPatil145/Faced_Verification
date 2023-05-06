import 'package:faced/main.dart';

class SharedPrefrence {
  static const _IS_LOGIN = "Face_isLogin";
  static const _USER_NAME = "Face_user";

  static const PROFILE_IMAGE = "profile_image";

  SharedPrefrence();

  static final SharedPrefrence _singleton = new SharedPrefrence._internal();

  // factory SharedPrefrence() {
  //   return _singleton;
  // }

  SharedPrefrence._internal();

  bool? getIsLogin() {
    return sharedPrefrence!.getBool(_IS_LOGIN);
  }

  setisLogin(bool islogin) {
    sharedPrefrence!.setBool(_IS_LOGIN, islogin);
  }

  String? getIsName() {
    return sharedPrefrence!.getString(_USER_NAME);
  }

  setIsName(String user_name) {
    sharedPrefrence!.setString(_USER_NAME, user_name);
  }

  String? getProfileImage() {
    return sharedPrefrence?.getString(PROFILE_IMAGE);
  }

  setProfileImage(String name) {
    sharedPrefrence?.setString(PROFILE_IMAGE, name);
  }

  Future<void> deleteAll() async {
    await sharedPrefrence!.clear();
  }
}
