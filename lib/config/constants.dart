// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

const textColor = Color(0xFF35485d);

const primary = Color(0xFF251abe);
const secondary = Color(0xFFb29be2);
const background = Color(0xFF3f34c7);
const surface = Color(0xFFe4dcf7);
const error = Color(0xFFfe485e);
const onPrimary = Color(0xFFFFFFFF);
const onSecondary = Color(0xFFFFFFFF);
const onError = Color(0xFF5e4342);
const onBackground = Color(0xFFa971c5);
const onSurface = Color(0xFFd5513c);

const endPoint = 'http://10.0.2.2/v1';
const projectId = '63d4047a9fc2de5c26f8';
const databaseId = '63d405066f49bba54099';
const storageBucketId = '63d4f955f316ba8686d9';
const usersCollectionId = '63d42bef0aad28d85da8';
const postsCollectionId = '63d4f2bf258d5493955e';

String imgURL(String imgId) =>
    '$endPoint/storage/buckets/$storageBucketId/files/$imgId/view?project=$projectId&mode=admin';
