import '../../models/user_model.dart';

abstract interface class UserRepository {
  Future<UserModel> findById(int id);
}
