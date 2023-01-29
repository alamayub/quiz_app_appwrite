import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_app/controllers/post_controller.dart';
import '../config/constants.dart';
import '../core/utils.dart';
import '../widgets/custom_material_button_widget.dart';

class CreatePostScreen extends ConsumerStatefulWidget {
  const CreatePostScreen({super.key});

  @override
  ConsumerState<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends ConsumerState<CreatePostScreen> {
  late TextEditingController _controller;
  List<File> images = [];

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loading = ref.watch(postControllerProvider);
    return WillPopScope(
      onWillPop: () async {
        FocusScope.of(context).unfocus();
        return !loading;
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 50,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.close,
              color: Colors.black,
            ),
          ),
          actions: [
            Container(
              margin: const EdgeInsets.only(
                top: 8,
                bottom: 8,
                right: 16,
              ),
              width: 80,
              child: CustomMaterialButtonWidget(
                radius: 20,
                elevation: 0,
                title: 'POST',
                loading: loading,
                onPressed: () =>
                    ref.read(postControllerProvider.notifier).sharePost(
                          images: images,
                          text: _controller.text.trim(),
                        ),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            TextField(
              controller: _controller,
              maxLines: null,
              decoration: const InputDecoration(
                hintText: 'What\'s happening?',
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: GridView.count(
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  children: images
                      .map((e) => Image.file(
                            e,
                            fit: BoxFit.cover,
                          ))
                      .toList(),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 0,
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  color: Colors.grey.shade300,
                  width: .3,
                ),
              ),
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () async {
                    images = await pickImages();
                    setState(() {});
                  },
                  icon: const Icon(
                    Icons.image,
                    color: primary,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.gif_box_outlined,
                    color: primary,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.insert_emoticon,
                    color: primary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
