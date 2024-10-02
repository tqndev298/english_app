import 'package:auto_size_text/auto_size_text.dart';
import 'package:english_app/models/english_today.dart';
import 'package:flutter/material.dart';

import '../values/app_assets.dart';
import '../values/app_colors.dart';
import '../values/app_styles.dart';

class AllWordsPage extends StatelessWidget {
  final List<EnglishToday> words;
  const AllWordsPage({Key? key, required this.words}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondColor,
      appBar: AppBar(
        title: Text(
          'English Today',
          style:
              AppStyles.h4.copyWith(color: AppColors.textColor, fontSize: 36),
        ),
        elevation: 0,
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Image.asset(AppAssets.leftArrow),
        ),
        backgroundColor: AppColors.secondColor,
      ),
      body: GridView.count(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        children: words
            .map((e) => Container(
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: AutoSizeText(
                    e.noun ?? '',
                    style: AppStyles.h3.copyWith(shadows: [
                      const BoxShadow(
                          color: Colors.black38,
                          offset: Offset(3, 6),
                          blurRadius: 6)
                    ]),
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                  ),
                ))
            .toList(),
      ),
    );
  }
}
