import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../core/providers.dart';
import '../core/type_defs.dart';
import '../models/post_model.dart';
import '../config/constants.dart';
import '../core/failure.dart';

final postAPIProvider = Provider(
  (ref) => PostAPI(
    db: ref.watch(appwriteDatabaseProvider),
    realtime: ref.watch(appwriteRealtimeProvider),
  ),
);

abstract class IPostAPI {
  FutureEither<Document> sharePost(PostModel postModel);
  Future<List<Document>> getPosts();
  Stream<RealtimeMessage> getLatestPost();
  FutureEither<Document> likePost(PostModel postModel);
}

class PostAPI implements IPostAPI {
  final Databases _db;
  final Realtime _realtime;
  PostAPI({required Databases db, required Realtime realtime})
      : _db = db,
        _realtime = realtime;
  @override
  FutureEither<Document> sharePost(PostModel postModel) async {
    try {
      final document = await _db.createDocument(
        databaseId: databaseId,
        collectionId: postsCollectionId,
        documentId: ID.unique(),
        data: postModel.toMap(),
      );
      return right(document);
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
  Future<List<Document>> getPosts() async {
    final documents = await _db.listDocuments(
      databaseId: databaseId,
      collectionId: postsCollectionId,
      queries: [Query.orderDesc('createdAt')],
    );
    return documents.documents;
  }

  @override
  Stream<RealtimeMessage> getLatestPost() => _realtime.subscribe([
        'databases.$databaseId.collections.$postsCollectionId.documents',
      ]).stream;

  @override
  FutureEither<Document> likePost(PostModel postModel) async {
    try {
      final document = await _db.updateDocument(
        databaseId: databaseId,
        collectionId: postsCollectionId,
        documentId: postModel.id,
        data: {
          'likes': postModel.likes,
        },
      );
      return right(document);
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
