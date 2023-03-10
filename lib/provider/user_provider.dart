import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:uresrs/models/user_models.dart';
import 'package:uresrs/repository/user_repository.dart';

class Homeprovider extends ChangeNotifier {
  Homeprovider() {
    getUser();
  }
  UserRepository userRepository = UserRepository();
  String error = "";
  bool isLoading = false;
  Box<UserModel>? data;
  void getUser() async {
    isLoading = true;
    notifyListeners();
    await userRepository.getUser().then((dynamic response) {
      if (response is Box<UserModel>) {
        isLoading = false;
        data = response;
        notifyListeners();
      } else {
        isLoading = false;
        error = response;
        notifyListeners();
      }
    });
  }
}