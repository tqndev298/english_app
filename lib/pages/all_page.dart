import 'package:english_app/models/english_today.dart';
import 'package:flutter/material.dart';

class AllWordsPage extends StatelessWidget {
  final List<EnglishToday> words;
  const AllWordsPage({Key? key, required this.words}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('all words'),
      ),
    );
  }
}
