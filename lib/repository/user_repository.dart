import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uresrs/models/user_models.dart';
import 'package:uresrs/service/user_servise.dart';

class UserRepository {
  GetUserService getUserService = GetUserService();
  Box<UserModel>? userBox;

  Future<dynamic> getUser() async {
    try {
      dynamic response = await getUserService.getUserService();
      if (response == null) {
        return "Error: Response was null";
      }
      if (response is List<UserModel>) {
        await openBox();
        await writeToBox(response);
        return userBox;
      } else {
        return response;
      }
    } catch (error) {
      return "Error: ${error.toString()}";
    }
  }

  void registerAdapter() {
    Hive.registerAdapter(UserModelAdapter());
    Hive.registerAdapter(AddressAdapter());
    Hive.registerAdapter(GeoAdapter());
    Hive.registerAdapter(CompanyAdapter());
  }

  Future<void> openBox() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocDir.path);
    userBox = await Hive.openBox<UserModel>("user");
  }

  Future<void> writeToBox(List<UserModel> data) async {
    await userBox!.clear();
    for (UserModel element in data) {
      await userBox!.add(element);
    }
  }
}