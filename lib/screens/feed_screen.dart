import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_app/models/post_model.dart';

import '../config/constants.dart';
import '../controllers/post_controller.dart';
import '../widgets/custom_text_widget.dart';
import '../widgets/loader.dart';
import '../widgets/post_card.dart';

class FeedScreen extends ConsumerWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getPostsProvider).when(
          data: (posts) {
            return ref.watch(getLatesPostProvider).when(
                  data: (data) {
                    if (data.events.contains(
                        'databases.*.collections.$postsCollectionId.documents.*.create')) {
                      final post = PostModel.fromMap(data.payload);
                      if (!posts.contains(post)) posts.insert(0, post);
                    }
                    return PostsListWidget(posts: posts);
                  },
                  error: (error, stackTrace) => Center(
                    child: CustomTextWidget(
                      maxLines: 5,
                      title: error.toString(),
                    ),
                  ),
                  loading: () => PostsListWidget(posts: posts),
                );
          },
          error: (error, stackTrace) => Center(
            child: CustomTextWidget(
              maxLines: 5,
              title: error.toString(),
            ),
          ),
          loading: () => const Loader(),
        );
  }
}

class PostsListWidget extends StatelessWidget {
  final List<PostModel> posts;

  const PostsListWidget({
    super.key,
    required this.posts,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) => PostCard(
        post: posts[index],
      ),
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemCount: posts.length,
    );
  }
}
