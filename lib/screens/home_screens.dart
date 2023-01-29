import 'package:flutter/material.dart';

import '../config/constants.dart';

class HomeScreeen extends StatelessWidget {
  const HomeScreeen({super.key});

  @override
  Widget build(Object context) {
    return GridView.count(
      shrinkWrap: true,
      primary: false,
      crossAxisCount: 2,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      children: List.generate(
          10,
          (index) => Container(
                decoration: BoxDecoration(
                  color: surface,
                  borderRadius: BorderRadius.circular(20),
                ),
              )),
    );
  }
}
