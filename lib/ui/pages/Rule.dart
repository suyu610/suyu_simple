import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:slimy_card/slimy_card.dart';
import 'package:suyu_simple/common/ThemeColor.dart';
import 'package:suyu_simple/common/ThemeFonts.dart';
import 'package:suyu_simple/sampleData/SampleDate.dart';
import 'package:suyu_simple/ui/components/MyButton.dart';
import 'package:suyu_simple/ui/components/Slimy_card.dart';

class RulePage extends StatefulWidget {
  RulePage({Key key}) : super(key: key);

  @override
  _RulePageState createState() => _RulePageState();
}

class _RulePageState extends State<RulePage> {
  final TextEditingController inputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // this.items = new List<String>.generate(10, (int index) => "Item: $index");
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
    inputController.dispose();
  }

  void onPageChanged(int index, CarouselPageChangedReason b) {
    // print(a);
    // print(b);
    _currentIndex = index;
    print(_currentIndex);
    setState(() {});
  }

  renderCustomCarousel() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 445.h,
        aspectRatio: 0.4,
        viewportFraction: 0.70,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: false,
        // autoPlayInterval: Duration(seconds: 8),
        // autoPlayAnimationDuration: Duration(milliseconds: 800),
        // autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        onPageChanged: onPageChanged,
        scrollDirection: Axis.horizontal,
      ),
      // items: cardList,
      items: SampleDate.CardList.map((String itemText) {
        return Column(
          children: [
            SlimyCard(
              bottomCardHeight: 100,
              color: ThemeColors.colorTheme,
              // In topCardWidget below, imagePath changes according to the
              // status of the SlimyCard(snapshot.data).
              topCardWidget:
                  topCardWidget(_currentIndex, 'assets/images/logo.png'),
              bottomCardWidget: bottomCardWidget(),
            ),
            SizedBox(
              height: 20.h,
            ),
            MyButton(
              "使用",
              tapAction: () => print(_currentIndex),
              height: 32,
            ),
          ],
        );
      }).toList(),
    );
  }

  int _currentIndex = 0;
  int _totalIndex = SampleDate.CardList.length;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: ThemeFonts.lineBoxDecoration,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(height: 10.h),
            Column(
              children: [
                GestureDetector(
                  onTap: () => {},
                  child: Container(
                    width: 150.w,
                    padding: EdgeInsets.all(5.w),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(254, 212, 91, 1),
                      boxShadow: [
                        new BoxShadow(
                            color: Color.fromRGBO(173, 179, 191, 0.3),
                            blurRadius: 1.0,
                            offset: new Offset(0, 0))
                      ],
                      border: Border.merge(
                        new Border(
                            left: BorderSide(color: Colors.black, width: 5)),
                        new Border(
                            right: BorderSide(color: Colors.black, width: 5)),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "当前拥有",
                          style: TextStyle(
                              letterSpacing: 5.w,
                              fontWeight: FontWeight.w900,
                              color: Colors.black,
                              fontSize: ScreenUtil().setSp(15),
                              fontFamily: 'myFont'),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  " ${SampleDate.CardList.length / 2} 朵小红花",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  " ${SampleDate.CardList.length} 张卡片",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "${_currentIndex + 1} / $_totalIndex",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          fontSize: 22.sp, color: Colors.grey.shade200),
                    ),
                    SizedBox(
                      width: 60.w,
                      height: 20.h,
                    )
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                this.renderCustomCarousel(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: SampleDate.CardList.map((url) {
                    int index = SampleDate.CardList.indexOf(url);
                    return Container(
                      width: 8.0,
                      height: 8.0,
                      margin:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentIndex == index
                              ? ThemeColors.colorTheme
                              : Colors.black),
                    );
                  }).toList(),
                ),
              ],
            ),
          ],
        ));
  }
}

// This widget will be passed as Top Card's Widget.
Widget topCardWidget(int index, String imagePath) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Container(
        height: 70,
        width: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(image: AssetImage(imagePath)),
        ),
      ),
      SizedBox(height: 15),
      Text(
        SampleDate.CardList[index],
        style: TextStyle(color: Colors.black, fontSize: 20),
      ),
      SizedBox(height: 15),
      Text(
        'He asks, what your name is. But!',
        style: TextStyle(
            color: Colors.black.withOpacity(0.8),
            fontSize: 12,
            fontWeight: FontWeight.w500),
      ),
      SizedBox(height: 10),
    ],
  );
}

// This widget will be passed as Bottom Card's Widget.
Widget bottomCardWidget() {
  return Text(
    '赠送时间 \n 2020-11-24',
    style: TextStyle(
      color: Colors.black,
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
    textAlign: TextAlign.center,
  );
}
