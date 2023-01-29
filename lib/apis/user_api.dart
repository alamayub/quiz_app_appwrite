import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as model;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:quiz_app/core/providers.dart';
import 'package:quiz_app/core/type_defs.dart';
import 'package:quiz_app/models/user_model.dart';

import '../config/constants.dart';
import '../core/failure.dart';

final userAPIProvider = Provider((ref) {
  return UserAPI(db: ref.watch(appwriteDatabaseProvider));
});

abstract class IUserAPI {
  FutureEitherVoid saveUserData(UserModel userModel);
  Future<model.Document> getuserData(String uid);
}

class UserAPI implements IUserAPI {
  final Databases _db;
  UserAPI({required Databases db}) : _db = db;
  @override
  FutureEitherVoid saveUserData(UserModel userModel) async {
    try {
      await _db.createDocument(
        databaseId: databaseId,
        collectionId: usersCollectionId,
        documentId: userModel.uid,
        data: userModel.toMap(),
      );
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
  Future<model.Document> getuserData(String uid) async {
    return await _db.getDocument(
      databaseId: databaseId,
      collectionId: usersCollectionId,
      documentId: uid,
    );
  }
}
