import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/models/post_model.dart';

class AnyLinkPreviewWidget extends StatelessWidget {
  final PostModel post;
  const AnyLinkPreviewWidget({
    super.key,
    required this.post,
  });

  @override
  Widget build(Object context) {
    String link = '';
    if (post.link.startsWith('https://') || post.link.startsWith('http://')) {
      link = post.link;
    } else {
      link = 'https://${post.link}';
    }
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.only(top: 6),
      child: AnyLinkPreview(
        link: link,
        displayDirection: UIDirection.uiDirectionHorizontal,
      ),
    );
  }
}
