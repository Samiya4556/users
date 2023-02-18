import 'package:dio/dio.dart';
import 'package:uresrs/models/user_models.dart';

class GetUserService {
  Future getUserService() async {
    try {
      Response response =
          await Dio().get("https://jsonplaceholder.typicode.com/users");
      if (response.statusCode == 200) {
        print("Hello");
        return (response.data as List)
            .map((e) => UserModel.fromJson(e))
            .toList();
      } else {
        return response.statusMessage;
      }
    } on DioError catch (e) {
      return e.message.toString();
    }
  }
}