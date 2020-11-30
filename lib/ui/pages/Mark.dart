import 'package:direct_select_flutter/direct_select_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:suyu_simple/constant/theme_color.dart';
import 'package:suyu_simple/constant/theme_fonts.dart';
import 'package:suyu_simple/provider/daily_mark_provider.dart';
import 'package:suyu_simple/provider/font_family_provider.dart';
import 'package:suyu_simple/provider/theme_provider.dart';

import 'package:suyu_simple/ui/components/Mark/mark_detail_li.dart';
import 'package:suyu_simple/ui/components/Mark/total_mark.dart';
import 'package:suyu_simple/ui/components/Menu/menu_widget.dart';
import 'package:suyu_simple/ui/components/my_button.dart';
import 'package:suyu_simple/viewmodels/mark_viewmodel.dart';

import '../base_view.dart';

class MarkPage extends StatefulWidget {
  MarkPage({Key key}) : super(key: key);

  @override
  _MarkPageState createState() => _MarkPageState();
}

class _MarkPageState extends State<MarkPage> {

  @override
  Widget build(BuildContext context) {
    return BaseView<MarkViewModel>(
        model: MarkViewModel(Provider.of(context), context),
        onModelReady: (model) {},
        builder: (context, model, child) {
          return _buildInnerDraw(context, model);
        });
  }
}

Widget _buildInnerDraw(BuildContext context, MarkViewModel model) {
  return InnerDrawer(
    key: Provider.of<ThemeProvider>(context, listen: false).innerDrawerKey,
    leftChild: _buildLeftChild(context, model),
    scaffold: _buildMainChild(context, model),
    // 一些配置
    onTapClose: true,
    swipe: true,
    colorTransitionChild: Colors.grey[900],
    colorTransitionScaffold: Colors.white70,
    offset: IDOffset.only(bottom: 0, right: 0, left: 0.6),
    proportionalChildArea: true,
    borderRadius: 0,
    leftAnimationType: InnerDrawerAnimation.quadratic,
    backgroundDecoration: BoxDecoration(color: Colors.grey[900]),
    innerDrawerCallback: (a) => {},
  );
}

Widget _buildLeftChild(BuildContext context, MarkViewModel model) {
  return GestureDetector(
      onHorizontalDragEnd: model.toggle, child: MenuWidget());
}

Widget _buildMainBox(BuildContext context, MarkViewModel model) {
  return Container(
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              Stack(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Text(
                      model.title(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(18),
                        fontFamily:
                            Provider.of<FontFamilyProvider>(context).fontFamily,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.h),
              ),
              Container(
                  height: 285.h,
                  child: Theme(
                    data: Theme.of(context)
                        .copyWith(accentColor: ThemeColors.colorWhite),
                    child: Center(
                      child: ListView.builder(
                          padding: const EdgeInsets.all(0),
                          itemCount: Provider.of<DailyMarkProvider>(context)
                              .getLength(), //.length,
                          itemBuilder: (BuildContext context, int index) {
                            return MarkDetailLi(index);
                          }),
                    ),
                  )),
            ],
          ),
          TotalMark(model.dailyRecorder.list),
        ],
      ),
    ),
    height: 400.h,
    width: 343.w,
    decoration: BoxDecoration(
      color: Color.fromRGBO(255, 255, 255, 0.5),
      border: Border.all(
        color: ThemeColors.colorBlack,
        width: 3, //边框粗细
      ), //容器内的方框弧度
      borderRadius: BorderRadius.all(const Radius.circular(10.0)),
    ),
  );
}

Widget _buildMainChild(BuildContext context, MarkViewModel model) {
  return Scaffold(
    key: Provider.of<ThemeProvider>(context).scaffoldKey,
    body: GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: DirectSelectContainer(
        child: Container(
          child: ConstrainedBox(
            constraints: BoxConstraints.expand(),
            child: Container(
              // color: Colors.white,
              decoration: ThemeFonts.lineBoxDecoration,
              child: Stack(
                alignment: Alignment.center, //指定未定位或部分定位widget的对齐方式
                children: <Widget>[
                  Positioned(
                    // left: ScreenUtil().setWidth(14),
                    right: 14.w,
                    top: 56.h,
                    child: GestureDetector(
                      onTap: model.handleSaveBtnClick,
                      child: Icon(Ionicons.settings_outline),
                    ),
                  ),
                  Positioned(
                    left: 14.w,
                    // right: ScreenUtil().setWidth(14),
                    top: 56.h,
                    child: GestureDetector(
                      onTap: model.openMenu,
                      child: Icon(Ionicons.menu),
                    ),
                  ),
                  Positioned(
                    left: ScreenUtil().setWidth(14),
                    right: ScreenUtil().setWidth(14),
                    top: 50.h,
                    child: Column(
                      children: <Widget>[
                        Text(model.nowDate(),
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: ScreenUtil().setSp(24),
                            )),
                        SizedBox(
                          height: 20.h,
                        ),
                        //中间的大盒子
                        _buildMainBox(context, model),
                        Padding(padding: EdgeInsets.all(10)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            MyButton(
                              "完美",
                              width: 120,
                              isYellow: true,
                              tapAction: model.handlePerfectBtnClick,
                            ),
                            MyButton("提交",
                                width: 170,
                                isYellow: false,
                                tapAction: model.handleSubmitBtnClick),
                          ],
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
