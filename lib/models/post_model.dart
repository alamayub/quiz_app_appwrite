// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:quiz_app/core/enums/post_type_enum.dart';

@immutable
class PostModel {
  final String text;
  final List<String> hashtags;
  final String link;
  final List<String> images;
  final String uid;
  final PostType postType;
  final DateTime createdAt;
  final List<String> likes;
  final List<String> commentIds;
  final String id;
  final int reshareCount;
  const PostModel({
    required this.text,
    required this.hashtags,
    required this.link,
    required this.images,
    required this.uid,
    required this.postType,
    required this.createdAt,
    required this.likes,
    required this.commentIds,
    required this.id,
    required this.reshareCount,
  });

  PostModel copyWith({
    String? text,
    List<String>? hashtags,
    String? link,
    List<String>? images,
    String? uid,
    PostType? postType,
    DateTime? createdAt,
    List<String>? likes,
    List<String>? commentIds,
    String? id,
    int? reshareCount,
  }) {
    return PostModel(
      text: text ?? this.text,
      hashtags: hashtags ?? this.hashtags,
      link: link ?? this.link,
      images: images ?? this.images,
      uid: uid ?? this.uid,
      postType: postType ?? this.postType,
      createdAt: createdAt ?? this.createdAt,
      likes: likes ?? this.likes,
      commentIds: commentIds ?? this.commentIds,
      id: id ?? this.id,
      reshareCount: reshareCount ?? this.reshareCount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'text': text,
      'hashtags': hashtags,
      'link': link,
      'images': images,
      'uid': uid,
      'postType': postType.type,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'likes': likes,
      'commentIds': commentIds,
      'reshareCount': reshareCount,
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      text: map['text'] as String,
      hashtags: List<String>.from((map['hashtags'])),
      link: map['link'] as String,
      images: List<String>.from((map['images'])),
      uid: map['uid'] as String,
      postType: (map['postType'] as String).toPostTypeEnum(),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      likes: List<String>.from((map['likes'])),
      commentIds: List<String>.from((map['commentIds'])),
      id: map['\$id'] as String,
      reshareCount: map['reshareCount'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory PostModel.fromJson(String source) =>
      PostModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PostModel(text: $text, hashtags: $hashtags, link: $link, images: $images, uid: $uid, postType: $postType, createdAt: $createdAt, likes: $likes, commentIds: $commentIds, id: $id, reshareCount: $reshareCount)';
  }

  @override
  bool operator ==(covariant PostModel other) {
    if (identical(this, other)) return true;

    return other.text == text &&
        listEquals(other.hashtags, hashtags) &&
        other.link == link &&
        listEquals(other.images, images) &&
        other.uid == uid &&
        other.postType == postType &&
        other.createdAt == createdAt &&
        listEquals(other.likes, likes) &&
        listEquals(other.commentIds, commentIds) &&
        other.id == id &&
        other.reshareCount == reshareCount;
  }

  @override
  int get hashCode {
    return text.hashCode ^
        hashtags.hashCode ^
        link.hashCode ^
        images.hashCode ^
        uid.hashCode ^
        postType.hashCode ^
        createdAt.hashCode ^
        likes.hashCode ^
        commentIds.hashCode ^
        id.hashCode ^
        reshareCount.hashCode;
  }
}
