import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:english_app/models/english_today.dart';
import 'package:english_app/packages/quote/quote.dart';
import 'package:english_app/pages/all_words_page.dart';
import 'package:english_app/pages/control_page.dart';
import 'package:english_app/values/app_assets.dart';
import 'package:english_app/values/app_colors.dart';
import 'package:english_app/values/app_styles.dart';
import 'package:english_app/values/share_keys.dart';
import 'package:english_app/widgets/app_button.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../packages/quote/qoute_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  late PageController _pageController;

  List<EnglishToday> words = [];

  String quote = Quotes().getRandom().content!;

  List<int> fixedListRandom({int len = 1, int max = 120, int min = 1}) {
    if (len > max || len < min) {
      return [];
    }
    List<int> newList = [];
    Random random = Random();
    int count = 1;
    while (count <= len) {
      int val = random.nextInt(max);
      if (newList.contains(val)) {
        continue;
      } else {
        newList.add(val);
        count++;
      }
    }
    return newList;
  }

  getEnglishToday() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    int len = pref.getInt(ShareKeys.counter) ?? 5;
    List<String> newList = [];
    List<int> rans = fixedListRandom(len: len, max: nouns.length);
    for (var index in rans) {
      newList.add(nouns[index]);
    }
    setState(() {
      words = newList.map((e) => getQuote(e)).toList();
    });
  }

  EnglishToday getQuote(String noun) {
    Quote? quote;
    quote = Quotes().getByWord(noun);
    return EnglishToday(
      noun: noun,
      quote: quote?.content,
      id: quote?.id,
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _pageController = PageController(viewportFraction: 0.9);
    super.initState();
    getEnglishToday();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
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
            _scaffoldKey.currentState?.openDrawer();
          },
          child: Image.asset(AppAssets.menu),
        ),
        backgroundColor: AppColors.secondColor,
      ),
      body: SizedBox(
        width: double.infinity,
        // margin: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            Container(
                height: size.height * 1 / 10,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                alignment: Alignment.centerLeft,
                child: Text(
                  '"$quote"',
                  style: AppStyles.h5
                      .copyWith(fontSize: 12, color: AppColors.textColor),
                )),
            SizedBox(
              height: size.height * 2 / 3,
              // color: Colors.red,
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  String firstLetter =
                      words[index].noun != null ? words[index].noun! : '';
                  firstLetter = firstLetter.substring(0, 1);
                  String leftLetter =
                      words[index].noun != null ? words[index].noun! : '';
                  leftLetter = leftLetter.substring(1, leftLetter.length);
                  String quoteDefault =
                      "Think of all the beauty still left around you and be happy.";
                  String quote = words[index].quote != null
                      ? words[index].quote!
                      : quoteDefault;
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      // margin: const EdgeInsets.symmetric(vertical: 16),
                      decoration: const BoxDecoration(
                          color: AppColors.primaryColor,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black38,
                                offset: Offset(3, 6),
                                blurRadius: 6)
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(24))),
                      child: index >= 5
                          ? InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) =>
                                            AllWordsPage(words: words)));
                              },
                              child: Center(
                                child: Text(
                                  'Show more ...',
                                  style: AppStyles.h3.copyWith(shadows: [
                                    const BoxShadow(
                                        color: Colors.black38,
                                        offset: Offset(3, 6),
                                        blurRadius: 6)
                                  ]),
                                ),
                              ),
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  alignment: Alignment.centerRight,
                                  child: Image.asset(AppAssets.heart),
                                ),
                                RichText(
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.start,
                                    text: TextSpan(
                                        text: firstLetter,
                                        style: const TextStyle(
                                            fontFamily: FontFamily.sen,
                                            fontSize: 80,
                                            fontWeight: FontWeight.bold,
                                            shadows: [
                                              BoxShadow(
                                                  color: Colors.black38,
                                                  offset: Offset(3, 6),
                                                  blurRadius: 6)
                                            ]),
                                        children: [
                                          TextSpan(
                                              text: leftLetter,
                                              style: const TextStyle(
                                                  fontFamily: FontFamily.sen,
                                                  fontSize: 45,
                                                  fontWeight: FontWeight.bold,
                                                  shadows: [
                                                    BoxShadow(
                                                        color: Colors.black38,
                                                        offset: Offset(3, 6),
                                                        blurRadius: 6)
                                                  ])),
                                        ])),
                                Padding(
                                  padding: const EdgeInsets.only(top: 24),
                                  child: AutoSizeText(
                                    '"$quote"',
                                    maxFontSize: 26,
                                    style: AppStyles.h4.copyWith(
                                        letterSpacing: 1,
                                        color: AppColors.textColor),
                                    textAlign: TextAlign.left,
                                  ),
                                )
                              ],
                            ),
                    ),
                  );
                },
                itemCount: words.length > 5 ? 6 : words.length,
              ),
            ),
            //Indicator
            _currentIndex >= 5
                ? buildShowMore()
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: SizedBox(
                      height: size.height * 1 / 11,
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        child: ListView.builder(
                            // physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return buildIndicator(
                                  index == _currentIndex, size);
                            }),
                      ),
                    ),
                  )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        onPressed: () {
          setState(() {
            getEnglishToday();
          });
        },
        child: Image.asset(AppAssets.exchange),
      ),
      drawer: Drawer(
        child: Container(
          color: AppColors.lighBlue,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 24, left: 16),
                child: Text(
                  'Your mind',
                  style: AppStyles.h3.copyWith(color: AppColors.textColor),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: AppButton(label: "Favorites", onTap: () {}),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: AppButton(
                    label: "Your Control",
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const ControlPage()));
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildIndicator(bool isActive, Size size) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.bounceIn,
      height: 8,
      margin: const EdgeInsets.symmetric(horizontal: 11),
      width: isActive ? size.width * 1 / 5 : 24,
      decoration: BoxDecoration(
          color: isActive ? AppColors.lighBlue : AppColors.lightGrey,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          boxShadow: const [
            BoxShadow(
                color: Colors.black38, offset: Offset(2, 3), blurRadius: 3)
          ]),
    );
  }

  Widget buildShowMore() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        alignment: Alignment.centerLeft,
        child: Material(
          borderRadius: const BorderRadius.all(Radius.circular(24)),
          elevation: 4,
          color: AppColors.primaryColor,
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => AllWordsPage(words: words)));
            },
            borderRadius: const BorderRadius.all(Radius.circular(24)),
            splashColor: Colors.black38,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Text(
                'Show more',
                style: AppStyles.h5,
              ),
            ),
          ),
        ));
  }
}
