import 'package:cinebox/config/result/result.dart';

abstract interface class GoogleSignInService {
  Future<Result<String>> signIn();
  Future<Result<Unit>> signOut();
  Future<Result<String>> isSignedIn();
}
