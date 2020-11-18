import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';

import 'package:suyu_simple/common/ThemeColor.dart';
import 'package:suyu_simple/ui/components/Carousel.dart';
import 'package:suyu_simple/ui/components/MyButton.dart';
// import 'package:slimy_card/slimy_card.dart';

class RulePage extends StatefulWidget {
  RulePage({Key key}) : super(key: key);

  @override
  _RulePageState createState() => _RulePageState();
}

class _RulePageState extends State<RulePage> {
  final TextEditingController inputController = TextEditingController();
  List<String> items;
  @override
  void initState() {
    super.initState();
    this.items = new List<String>();
    items.add("亲亲卡");
    items.add("抱抱卡");
    items.add("亲耳朵卡");
    items.add("打屁股卡");
    items.add("口交卡");
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

  renderCustomCarousel() {
    return Column(
      children: <Widget>[
        Carousel(
          rowCount: 1,
          onDragStart: (DragStartDetails details) {},
          onDrag: (DragUpdateDetails details) {},
          onDragEnd: (DragEndDetails details) {},
          children: this.items.map((String itemText) {
            return Padding(
                padding: const EdgeInsets.only(
                    bottom: 0, top: 10.0, left: 0, right: 0),
                child: Container(
                  margin: const EdgeInsets.only(
                      top: 10.0, bottom: 30.0, left: 65, right: 65),
                  decoration: BoxDecoration(
                    border: Border.all(width: 2),
                    color: ThemeColors.colorTheme,
                    borderRadius: BorderRadius.all(
                      Radius.circular(19),
                      // topLeft: Radius.elliptical(30, 50),
                      // topRight: Radius.elliptical(90, 50),
                      // bottomRight: Radius.elliptical(50, 99),
                      // bottomLeft: Radius.elliptical(50, 92),
                    ),
                    boxShadow: [
                      BoxShadow(
                        // color: ThemeColors.colorTheme,
                        color: Colors.black,
                        spreadRadius: 0.0,
                        offset: Offset(7.0, 7.0),
                      )
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        itemText,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Image.asset(
                        'assets/images/logo.png',
                        width: 100.0,
                        height: 100.0,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                ));
          }).toList(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                    new Border(left: BorderSide(color: Colors.black, width: 5)),
                    new Border(
                        right: BorderSide(color: Colors.black, width: 5)),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Ionicons.flower_outline,
                      color: Colors.black,
                      size: 18.sp,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 5.w),
                    ),
                    Text(
                      "仓库",
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
            Column(
              children: [
                this.renderCustomCarousel(),
                MyButton(
                  "使用",
                  isYellow: true,
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            )
          ],
        )),
      ),
    );
  }
}
