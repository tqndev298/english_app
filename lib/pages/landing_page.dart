import 'package:english_app/pages/home_page.dart';
import 'package:english_app/values/app_assets.dart';
import 'package:english_app/values/app_colors.dart';
import 'package:english_app/values/app_styles.dart';
import 'package:flutter/material.dart';

class langdingPage extends StatelessWidget {
  const langdingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Column(
        children: [
          Expanded(
              child: Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'Welcome to',
              style: AppStyles.h3,
            ),
          )),
          Expanded(
              child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'English',
                  style: AppStyles.h2.copyWith(
                      color: AppColors.blackGrey, fontWeight: FontWeight.bold),
                ),
                Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Text(
                      'Qoutes*',
                      textAlign: TextAlign.right,
                      style: AppStyles.h4,
                    ))
              ],
            ),
          )),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(bottom: 72),
            child: RawMaterialButton(
              fillColor: AppColors.lighBlue,
              shape: CircleBorder(),
              onPressed: () {
                // Navigator.push(context,
                // MaterialPageRoute(builder: (context) => HomePage()));
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => HomePage()),
                    (route) => false);
              },
              child: Image.asset(AppAssets.rightArrow),
            ),
          )),
        ],
      ),
    );
  }
}
