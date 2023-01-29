import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_app/apis/post_api.dart';
import 'package:quiz_app/apis/storage_api.dart';
import 'package:quiz_app/config/constants.dart';
import 'package:quiz_app/controllers/auth_controller.dart';
import 'package:quiz_app/core/enums/post_type_enum.dart';
import 'package:quiz_app/core/utils.dart';
import 'package:quiz_app/models/post_model.dart';
import 'package:quiz_app/models/user_model.dart';

final postControllerProvider = StateNotifierProvider<PostController, bool>(
  (ref) => PostController(
    ref: ref,
    postAPI: ref.watch(postAPIProvider),
    storageAPI: ref.watch(storageAPIProvider),
  ),
);

final getPostsProvider = FutureProvider((ref) async {
  final postController = ref.watch(postControllerProvider.notifier);
  return postController.getPosts();
});

final getLatesPostProvider =
    StreamProvider((ref) => ref.watch(postAPIProvider).getLatestPost());

class PostController extends StateNotifier<bool> {
  final PostAPI _postAPI;
  final StorageAPI _storageAPI;
  final Ref _ref;
  PostController({
    required PostAPI postAPI,
    required StorageAPI storageAPI,
    required Ref ref,
  })  : _postAPI = postAPI,
        _storageAPI = storageAPI,
        _ref = ref,
        super(false);

  // get all lists of posts
  Future<List<PostModel>> getPosts() async {
    final postsList = await _postAPI.getPosts();
    return postsList.map((e) => PostModel.fromMap(e.data)).toList();
  }

  // post a post
  void sharePost({
    required List<File> images,
    required String text,
  }) {
    if (text.isEmpty) {
      showSnackBar('Please enter some text...');
      return;
    }
    if (images.isNotEmpty) {
      _postImages(images: images, text: text);
    } else {
      _postText(text: text);
    }
  }

  // like post
  void likePost(PostModel postModel, UserModel userModel) async {
    List<String> likes = postModel.likes;
    if (likes.contains(userModel.uid)) {
      likes.remove(userModel.uid);
    } else {
      likes.add(userModel.uid);
    }
    postModel = postModel.copyWith(likes: likes);
    final res = await _postAPI.likePost(postModel);
    res.fold((l) => null, (r) => null);
  }

  // share post with images
  void _postImages({
    required List<File> images,
    required String text,
  }) async {
    try {
      state = true;
      final link = _getLinkFromText(text);
      final hashtags = _getHastagsFromText(text);
      final user = _ref.read(currentUserAccountProvider).value!;
      final imageLinks = await _storageAPI.uploadImages(images);
      PostModel postModel = PostModel(
        text: text,
        hashtags: hashtags,
        link: link,
        images: imageLinks,
        uid: user.$id,
        postType: PostType.text,
        createdAt: DateTime.now(),
        likes: const [],
        commentIds: const [],
        id: '',
        reshareCount: 0,
      );
      final res = await _postAPI.sharePost(postModel);
      res.fold(
        (l) => showSnackBar(l.message),
        (r) {
          showSnackBar('Posted successfully!');
          navigatorKey.currentState!.pop();
        },
      );
      state = false;
    } catch (e) {
      showSnackBar(e.toString());
    }
  }

  // share post with text
  void _postText({required String text}) async {
    try {
      state = true;
      final link = _getLinkFromText(text);
      final hashtags = _getHastagsFromText(text);
      final user = _ref.read(currentUserAccountProvider).value!;
      PostModel postModel = PostModel(
        text: text,
        hashtags: hashtags,
        link: link,
        images: const [],
        uid: user.$id,
        postType: PostType.text,
        createdAt: DateTime.now(),
        likes: const [],
        commentIds: const [],
        id: '',
        reshareCount: 0,
      );
      final res = await _postAPI.sharePost(postModel);
      res.fold(
        (l) => showSnackBar(l.message),
        (r) {
          showSnackBar('Posted successfully!');
          navigatorKey.currentState!.pop();
        },
      );
      state = false;
    } catch (e) {
      showSnackBar(e.toString());
    }
  }

  // get link from text
  String _getLinkFromText(String text) {
    List<String> links = ['http://', 'https://', 'www.'];
    List<String> words = text.split(' ');
    String link = '';
    for (var word in words) {
      if (word.startsWith(links[0]) ||
          word.startsWith(links[1]) ||
          word.startsWith(links[2])) {
        link = word;
      }
    }
    return link;
  }

  // get hashtags from text
  List<String> _getHastagsFromText(String text) {
    List<String> hashtags = [];
    List<String> words = text.split(' ');
    for (var word in words) {
      if (word.startsWith('#')) {
        hashtags.add(word);
      }
    }
    return hashtags;
  }
}
