import 'dart:developer';

import 'package:cinebox/config/result/result.dart';
import 'package:cinebox/data/exceptions/data_exception.dart';
import 'package:cinebox/data/services/auth/auth_service.dart';
import 'package:cinebox/data/services/google_signin/google_signin_service.dart';
import 'package:cinebox/data/services/local_storage/local_storage_service.dart';
import 'package:dio/dio.dart';

import './auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final GoogleSignInService _googleSignInService;
  final LocalStorageService _localStorageService;
  final AuthService _authService;

  AuthRepositoryImpl({
    required GoogleSignInService googleSignInService,
    required LocalStorageService localStorageService,
    required AuthService authService,
  }) : _googleSignInService = googleSignInService,
       _localStorageService = localStorageService,
       _authService = authService;

  @override
  Future<Result<bool>> isLogged() async {
    final resultToken = await _localStorageService.getIdToken();
    return switch (resultToken) {
      Success<String>() => Success(true),
      Failure<String>() => Success(false),
    };
  }

  @override
  Future<Result<Unit>> signIn() async {
    final result = await _googleSignInService.signIn();
    switch (result) {
      case Success<String>(:final value):
        try {
          await _localStorageService.saveIdToken(value);
          await _authService.auth();
          return successOfUnit();
        } on DioException catch (e, st) {
          log(
            'Error on authenticate user on backend',
            name: 'AuthRepository',
            error: e,
            stackTrace: st,
          );
          return Failure(DataException('Error on authenticate user on backend'));
        }
      case Failure<String>(error: final erro):
        log('Error on login with Google', name: 'AuthRepository', error: erro);
        return Failure(DataException('Error on login with Google'));
    }
  }

  @override
  Future<Result<Unit>> signOut() async {
    final result = await _googleSignInService.signOut();
    switch (result) {
      case Success<Unit>():
        final removeResult = await _localStorageService.removeIdToken();
        switch (removeResult) {
          case Success<Unit>():
            return successOfUnit();
          case Failure<Unit>(error: final erro):
            log('Error on logOut ID Token', name: 'AuthRepository', error: erro);
            return Failure(DataException('Error on logOut ID Token'));
        }
      case Failure<Unit>(error: final erro):
        log('Error on logOut with Google', name: 'AuthRepository', error: erro);
        return Failure(DataException('Error on logOut with Google'));
    }
  }
}
