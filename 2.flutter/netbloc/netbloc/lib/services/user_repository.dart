


import 'package:netbloc/models/user.dart';
import 'package:netbloc/services/user_api_provider.dart';

class UserRepository {
  UserApiProvider _usersProvider = UserApiProvider();
  Future<List<User>> getAllUsers(){
    return _usersProvider.getUsers();
  }
}