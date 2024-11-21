
import 'package:searcheable_list/services/user_api_provider.dart';
import 'package:time_scheduler_table/time_scheduler_table.dart';

class UsersRepository {
  UserApiProvider _usersProvider = UserApiProvider();
  Future<List<Event>> getAllUsers(){
    return _usersProvider.getUsers();
  }
} 