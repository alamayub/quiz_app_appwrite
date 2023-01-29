import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_app/config/constants.dart';
import 'package:quiz_app/controllers/post_controller.dart';
import 'package:quiz_app/widgets/any_link_preview_widget.dart';
import 'package:quiz_app/widgets/custom_image_provider_widget.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../controllers/auth_controller.dart';
import '../models/post_model.dart';
import 'custom_text_widget.dart';
import 'loader.dart';
import 'post_text_widget.dart';

class PostCard extends ConsumerWidget {
  final PostModel post;
  const PostCard({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var user = ref.watch(currentUserDetailsProvider).value;
    return user != null
        ? ref.watch(userDetailsProvider(post.uid)).when(
              data: (data) => Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: CustomImageProviderWidget(image: data.profilePic),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextWidget(
                            title:
                                '${data.name} @${data.name} . ${timeago.format(
                          post.createdAt,
                          locale: 'en_short',
                        )}'),
                        const SizedBox(height: 3),
                        PostTextWidget(text: post.text),
                        if (post.images.isNotEmpty)
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: GridView.count(
                              padding: EdgeInsets.zero,
                              primary: false,
                              shrinkWrap: true,
                              crossAxisCount: 3,
                              children: post.images
                                  .map((e) =>
                                      CustomImageProviderWidget(image: e))
                                  .toList(),
                            ),
                          ),
                        if (post.link.isNotEmpty)
                          AnyLinkPreviewWidget(post: post),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            PostCardActionButton(
                              iconData: Icons.poll_outlined,
                              total: post.commentIds.length +
                                  post.likes.length +
                                  post.reshareCount,
                              onTap: () {},
                            ),
                            PostCardActionButton(
                              iconData: Icons.comment_outlined,
                              total: post.commentIds.length,
                              onTap: () {},
                            ),
                            PostCardActionButton(
                              iconData: Icons.sync,
                              total: post.reshareCount,
                              onTap: () {},
                            ),
                            PostCardActionButton(
                              color: error,
                              iconData: post.likes.contains(user.uid)
                                  ? Icons.favorite
                                  : Icons.favorite_outline,
                              total: post.likes.length,
                              onTap: () => ref
                                  .read(postControllerProvider.notifier)
                                  .likePost(post, user),
                            ),
                            PostCardActionButton(
                              iconData: Icons.share,
                              onTap: () {},
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Divider(height: 0),
                      ],
                    ),
                  ),
                ],
              ),
              error: (error, stackTrace) => Center(
                child: CustomTextWidget(
                  maxLines: 5,
                  title: error.toString(),
                ),
              ),
              loading: () => const Loader(),
            )
        : const SizedBox();
  }
}

class PostCardActionButton extends StatelessWidget {
  final int? total;
  final IconData iconData;
  final VoidCallback onTap;
  final Color? color;
  const PostCardActionButton({
    super.key,
    this.total,
    required this.iconData,
    required this.onTap,
    this.color = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(iconData, color: color),
          if (total != null) const SizedBox(width: 4),
          if (total != null) CustomTextWidget(title: total.toString()),
        ],
      ),
    );
  }
}
