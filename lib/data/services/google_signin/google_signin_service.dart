import 'package:cinebox/data/core/result/result.dart';

abstract interface class GoogleSignInService {
  Future<Result<String>> signIn();
  Future<Result<Unit>> signOut();
  Future<Result<String>> isSignedIn();
}
