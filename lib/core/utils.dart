import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quiz_app/config/constants.dart';
import 'package:quiz_app/widgets/custom_text_widget.dart';

void showSnackBar(String content) {
  scaffoldMessengerKey.currentState!..hideCurrentSnackBar()..showSnackBar(
    SnackBar(
      elevation: 6,
      backgroundColor: Colors.white,
      content: CustomTextWidget(
        maxLines: 5,
        title: content,
      ),
    ),
  );
}

String getNameFromEmail(String email) => email.split('@')[0];

// pick multiple images from gallery
Future<List<File>> pickImages() async {
  List<File> images = [];
  final imagePicker = ImagePicker();
  final imagesFiles = await imagePicker.pickMultiImage();
  if (imagesFiles.isNotEmpty) {
    for (var file in imagesFiles) {
      images.add(File(file.path));
    }
  }
  return images;
}
