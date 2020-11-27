import 'package:flutter/material.dart';
import 'package:flutter_beautiful_popup/main.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:suyu_simple/constant/theme_color.dart';
import 'package:suyu_simple/constant/theme_fonts.dart';
import 'package:suyu_simple/model/maze/item.dart';
import 'package:suyu_simple/route/RouterHelper.dart';
import 'package:suyu_simple/ui/pages/maze/maze_painter.dart';
import 'package:suyu_simple/ui/pages/maze/maze_widget.dart';

class BreakGame extends StatefulWidget {
  BreakGame({Key key}) : super(key: key);

  @override
  _BreakGameState createState() => _BreakGameState();
}
// GlobalKey<_MazeState> globalKey = GlobalKey();

class _BreakGameState extends State<BreakGame> {
  Maze maze;
  BeautifulPopup popup;

  void throughCheckPoint(int index) {
    print(index);
    shitsList.removeLast();
    setState(() {});
  }

  List<MazeItem> shitsList;
  @override
  void initState() {
    super.initState();
    popup = BeautifulPopup(
      context: context,
      template: TemplateFail,
    );

    shitsList = [
      MazeItem('assets/images/shit.png', ImageType.asset),
      MazeItem('assets/images/shit.png', ImageType.asset),
      // MazeItem('assets/images/shit.png', ImageType.asset),
      // MazeItem('assets/images/shit.png', ImageType.asset),
      // MazeItem('assets/images/shit.png', ImageType.asset),
      MazeItem('assets/images/shit.png', ImageType.asset),
    ];

    maze = Maze(
        height: 300.h,
        key: childKey,
        checkpoints: shitsList,
        onCheckpoint: (value) => throughCheckPoint(value),
        player: MazeItem('assets/images/girl.png', ImageType.asset),
        columns: 15,
        rows: 15,
        wallThickness: 3.0,
        wallColor: ThemeColors.colorBlack,
        finish: MazeItem('assets/images/heartbreak.png', ImageType.asset),
        onFinish: showDialog);
  }

  void showDialog() {
    if (shitsList.length != 0) {
      EasyLoading.showError("还没吃光大便");
      return;
    }
    popup.show(
        title: Text(
          '确定要与他断绝关系吗?',
          style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
        ),
        content: Text(
          "分手后，您的手机号，邮箱，IP地址将不允许再次注册本app。\n",
          style: TextStyle(fontSize: 14.sp),
        ),
        actions: [
          popup.button(
            label: "确认",
            onPressed: Navigator.of(context).pop,
            outline: true,
          ),
          popup.button(
            label: '再想想',
            onPressed: Navigator.of(context).pop,
          ),
        ]);
  }

  void refresh() {
    print("11");

    setState(() {});
  }

  final double buttonSize = 60.h;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ThemeFonts.lineBoxDecoration,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          maze,
          Text(
            shitsList.length == 0 ? "嗝,吃光了" : "你还需要吃${shitsList.length}坨大便才能分手",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
          ),
          // SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
                      decoration: BoxDecoration(
                          color: ThemeColors.colorTheme,
                          border: Border.all(width: 3),
                          borderRadius: BorderRadius.circular(buttonSize / 2)),
                      height: buttonSize / 1.5,
                      width: buttonSize / 1.5,
                      child: Center(
                          child: Icon(
                        Icons.refresh_outlined,
                        size: 20.sp,
                        color: Colors.black,
                      ))),
                ),
                onPressed: refresh,
                minWidth: buttonSize,
                height: buttonSize,
              ),
              FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
                      decoration: BoxDecoration(
                          color: ThemeColors.colorTheme,
                          border: Border.all(width: 3),
                          borderRadius: BorderRadius.circular(buttonSize / 2)),
                      height: buttonSize / 1.5,
                      width: buttonSize / 1.5,
                      child: Center(
                          child: Icon(
                        Icons.exit_to_app_rounded,
                        size: 20.sp,
                        color: Colors.black,
                      ))),
                ),
                onPressed: () => RouterHelper.router.pop(context),
                minWidth: buttonSize,
                height: buttonSize,
              ),
            ],
          ),

          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlatButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Container(
                          decoration: BoxDecoration(

                              // color: Colors.black,
                              border: Border.all(width: 4),
                              borderRadius:
                                  BorderRadius.circular(buttonSize / 2)),
                          height: buttonSize,
                          width: buttonSize,
                          child: Center(
                              child: Icon(
                            Icons.arrow_upward,
                            size: 30.sp,
                            color: Colors.black,
                          ))),
                    ),
                    onPressed: () => childKey.currentState.move(Direction.up),
                    minWidth: buttonSize,
                    height: buttonSize,
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlatButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Container(
                          decoration: BoxDecoration(
                              // color: Colors.black,
                              border: Border.all(width: 4),
                              borderRadius:
                                  BorderRadius.circular(buttonSize / 2)),
                          height: buttonSize,
                          width: buttonSize,
                          child: Center(
                              child: Icon(
                            Icons.chevron_left,
                            color: Colors.black,
                            size: 30.sp,
                          ))),
                    ),
                    onPressed: () => childKey.currentState.move(Direction.left),
                    minWidth: buttonSize,
                    height: buttonSize,
                  ),
                  SizedBox(width: 0.h),
                  FlatButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Container(
                          decoration: BoxDecoration(
                              // color: Colors.black,
                              border: Border.all(width: 4),
                              borderRadius:
                                  BorderRadius.circular(buttonSize / 2)),
                          height: buttonSize,
                          width: buttonSize,
                          child: Center(
                              child: Icon(Icons.arrow_downward,
                                  size: 30.sp, color: Colors.black))),
                    ),
                    onPressed: () => childKey.currentState.move(Direction.down),
                    minWidth: buttonSize,
                    height: buttonSize,
                  ),
                  SizedBox(width: 0.h),
                  FlatButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Container(
                          decoration: BoxDecoration(
                              // color: Colors.black,
                              border: Border.all(width: 4),
                              borderRadius:
                                  BorderRadius.circular(buttonSize / 2)),
                          height: buttonSize,
                          width: buttonSize,
                          child: Center(
                              child: Icon(Icons.chevron_right,
                                  size: 30.sp, color: Colors.black))),
                    ),
                    onPressed: () =>
                        childKey.currentState.move(Direction.right),
                    minWidth: buttonSize,
                    height: buttonSize,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
