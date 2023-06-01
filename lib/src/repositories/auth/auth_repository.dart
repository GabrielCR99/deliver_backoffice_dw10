abstract interface class AuthRepository {
  Future<String> login({required String email, required String password});
}
