import 'package:cinebox/config/result/result.dart';

abstract interface class AuthRepository {
  Future<Result<bool>> isLogged();
  Future<Result<Unit>> signIn();
  Future<Result<Unit>> signOut();
}
