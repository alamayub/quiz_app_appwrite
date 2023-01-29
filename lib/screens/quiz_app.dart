import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_app/screens/create_post_screen.dart';
import 'package:quiz_app/screens/feed_screen.dart';
import 'package:quiz_app/screens/home_screens.dart';
import 'package:quiz_app/screens/profile_screen.dart';
import 'package:quiz_app/screens/search_screen.dart';

import '../config/constants.dart';
import '../controllers/auth_controller.dart';

class QuizApp extends ConsumerStatefulWidget {
  const QuizApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _QuizAppState();
}

class _QuizAppState extends ConsumerState<QuizApp> {
  int _index = 0;

  static const _pages = [
    HomeScreeen(),
    SearchScreen(),
    FeedScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => ref.read(authControllerProvider.notifier).logout(),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      extendBody: true,
      body: _pages[_index],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CreatePostScreen(),
          ),
        ),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: _bottomNavigationBarWidget(),
    );
  }

  Widget _bottomNavigationBarWidget() {
    Size size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(16.0),
        topRight: Radius.circular(16.0),
      ),
      child: BottomAppBar(
        notchMargin: 8,
        clipBehavior: Clip.antiAlias,
        shape: const CircularNotchedRectangle(),
        child: SizedBox(
          height: 60,
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  setState(() => _index = 0);
                },
                child: SizedBox(
                  height: double.infinity,
                  width: size.width * .2,
                  child: Icon(
                    _index == 0 ? Icons.home : Icons.home_outlined,
                    color: textColor,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() => _index = 1);
                },
                child: SizedBox(
                  height: double.infinity,
                  width: size.width * .2,
                  child: const Icon(
                    Icons.search,
                    color: textColor,
                  ),
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  setState(() => _index = 2);
                },
                child: SizedBox(
                  height: double.infinity,
                  width: size.width * .2,
                  child: Icon(
                    _index == 2 ? Icons.feed : Icons.feed_outlined,
                    color: textColor,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() => _index = 3);
                },
                child: SizedBox(
                  height: double.infinity,
                  width: size.width * .2,
                  child: Icon(
                    _index == 3 ? Icons.person : Icons.person_outline,
                    color: textColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
