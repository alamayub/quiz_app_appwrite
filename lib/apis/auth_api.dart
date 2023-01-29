import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as model;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:quiz_app/core/failure.dart';
import 'package:quiz_app/core/providers.dart';
import 'package:quiz_app/core/type_defs.dart';

// want to resgister, want to get user account -> Account //import 'package:appwrite/appwrite.dart';
// want to access user related data -> model.Account  // import 'package:appwrite/models.dart' as Model;
abstract class IAuthAPI {
  // register user with name, email and password
  FutureEither<model.Account> signUp({
    required String name,
    required String email,
    required String password,
  });

  // login user with email and password
  FutureEither<model.Session> login({
    required String email,
    required String password,
  });

  // get current user
  Future<model.Account?> currentuserAccount();

  // logout current user
  FutureEitherVoid logout();

  // start with mobile number
  FutureEither<model.Session> loginWithMobileNumber({required String phone});
}

final authAPIProvider = Provider((ref) {
  final account = ref.watch(appwriteAccountProvider);
  return AuthAPI(account: account);
});

class AuthAPI implements IAuthAPI {
  final Account _account;
  AuthAPI({required Account account}) : _account = account;

  @override
  FutureEither<model.Account> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final account = await _account.create(
        userId: ID.unique(),
        email: email,
        password: password,
      );
      return right(account);
    } on AppwriteException catch (e, stackTrace) {
      return left(Failure(
        e.message ?? 'Unexpected error occurred!',
        stackTrace,
      ));
    } catch (e, stackTrace) {
      return left(Failure(
        e.toString(),
        stackTrace,
      ));
    }
  }

  @override
  FutureEither<model.Session> login({
    required String email,
    required String password,
  }) async {
    try {
      final session = await _account.createEmailSession(
        email: email,
        password: password,
      );
      return right(session);
    } on AppwriteException catch (e, stackTrace) {
      return left(Failure(
        e.message ?? 'Unexpected error occurred!',
        stackTrace,
      ));
    } catch (e, stackTrace) {
      return left(Failure(
        e.toString(),
        stackTrace,
      ));
    }
  }

  @override
  Future<model.Account?> currentuserAccount() async {
    try {
      return await _account.get();
    } on AppwriteException catch (_) {
      return null;
    } catch (_) {
      return null;
    }
  }

  @override
  FutureEitherVoid logout() async {
    try {
      await _account.deleteSession(sessionId: 'current');
      return right(null);
    } on AppwriteException catch (e, stackTrace) {
      return left(Failure(
        e.message ?? 'Unexpected error occurred!',
        stackTrace,
      ));
    } catch (e, stackTrace) {
      return left(Failure(
        e.toString(),
        stackTrace,
      ));
    }
  }

  @override
  FutureEither<model.Session> loginWithMobileNumber({
    required String phone,
  }) async {
    try {
      await _account.ph();
      return right(null);
    } on AppwriteException catch (e, stackTrace) {
      return left(Failure(
        e.message ?? 'Unexpected error occurred!',
        stackTrace,
      ));
    } catch (e, stackTrace) {
      return left(Failure(
        e.toString(),
        stackTrace,
      ));
    }
  }
}
