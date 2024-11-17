




import 'package:searcheable_list/models/user.dart';
import 'package:searcheable_list/services/user_api_provider.dart';

class UsersRepository {
  UserApiProvider _usersProvider = UserApiProvider();
  Future<List<User>> getAllUsers(){
    return _usersProvider.getUsers();
  }
} 