import 'dart:io';

import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_app/config/constants.dart';
import 'package:quiz_app/core/providers.dart';

final storageAPIProvider = Provider(
  (ref) => StorageAPI(
    storage: ref.watch(appwriteStorageProvider),
  ),
);

class StorageAPI {
  final Storage _storage;
  StorageAPI({required Storage storage}) : _storage = storage;

  // upload multiple images
  Future<List<String>> uploadImages(List<File> files) async {
    List<String> imageLinks = [];
    for (final file in files) {
      final uploadedImage = await _storage.createFile(
        bucketId: storageBucketId,
        fileId: ID.unique(),
        file: InputFile(
          path: file.path,
        ),
      );
      imageLinks.add(imgURL(uploadedImage.$id));
    }
    return imageLinks;
  }
}
