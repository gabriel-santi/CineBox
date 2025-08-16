import 'dart:developer';

import 'package:cinebox/config/result/result.dart';
import 'package:google_sign_in/google_sign_in.dart';

import './google_signin_service.dart';

class GoogleSigninServiceImpl implements GoogleSignInService {
  @override
  Future<Result<String>> isSignedIn() async {
    try {
      final logged = await GoogleSignIn.instance.attemptLightweightAuthentication();

      if (logged case GoogleSignInAccount(authentication: GoogleSignInAuthentication(:final idToken?))) {
        return Success(idToken);
      }

      return Failure(Exception("Usuário não logado com Google"));
    } catch (e, s) {
      log(
        'Usuário não logado com Google',
        name: "GoogleSignInService",
        error: e,
        stackTrace: s,
      );
      return Failure(Exception("Usuário não logado com Google"));
    }
  }

  @override
  Future<Result<String>> signIn() async {
    try {
      final auth = await GoogleSignIn.instance.authenticate(
        scopeHint: ['email', 'profile', 'openid'],
      );

      if (auth.authentication case GoogleSignInAuthentication(idToken: final idToken?)) {
        return Success(idToken);
      }
      return Failure(Exception('Erro ao obter Token do Google Sign-In'));
    } catch (e, s) {
      log(
        'Erro ao obter Token do Google Sign-In',
        name: "GoogleSignInService",
        error: e,
        stackTrace: s,
      );
      return Failure(Exception('Erro ao obter Token do Google Sign-In'));
    }
  }

  @override
  Future<Result<Unit>> signOut() async {
    try {
      await GoogleSignIn.instance.signOut();
      return successOfUnit();
    } catch (e, s) {
      log(
        'Erro ao realizar logout com Google',
        name: "GoogleSignInService",
        error: e,
        stackTrace: s,
      );
      return Failure(Exception('Erro ao realizar logout com Google'));
    }
  }
}
