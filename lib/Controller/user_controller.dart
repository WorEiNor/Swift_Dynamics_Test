import '../Model/user_model/user_model.dart';

class UserController {
  Future<List<UserModel>> getUserList() async {
    final response = await Future.delayed(
      Duration(seconds: 2),
    ).then((value) => usersList);
    print(response);
    return response;
  }

  Future<String> postUser(UserModel user) async {
    await Future.delayed(
      Duration(seconds: 1),
    ).then(
      (value) {
        usersList.add(user);
        print(usersList.length);
      },
    );

    return 'success';
  }

  Future<String> deleteUser(String id) async {
    await Future.delayed(
      Duration(seconds: 1),
    ).then(
      (value) {
        usersList.removeWhere((element) => element.id == id);
      },
    );

    return 'success';
  }
}

List<UserModel> usersList = [];
