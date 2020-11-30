import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:suyu_simple/constant/theme_color.dart';
import 'package:suyu_simple/constant/theme_fonts.dart';

import 'lyric/lyric_controller.dart';
import 'lyric/lyric_util.dart';
import 'lyric/lyric_widget.dart';

class SongPage extends StatefulWidget {
  SongPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SongPageState createState() => _SongPageState();
}

class _SongPageState extends State<SongPage> with TickerProviderStateMixin {
  //歌词
  var songLyc = '''
      [ti:夜空中最亮的星]
[ar:逃跑计划乐队]
[al:夜空中最亮的星]
[by:prince]
[00:00.03]夜空中最亮的星 - 逃跑计划乐队
[03:51.69][00:18.42]夜空中最亮的星
[03:55.92][00:22.62]能否听清
[04:00.30][00:26.94]那仰望的人
[04:02.57][00:29.26]心底的孤独和叹息
[00:33.69]
[00:36.10]夜空中最亮的星
[00:40.35]能否记起
[00:44.64]曾与我同行
[00:47.00]消失在风里的身影
[00:52.58]我祈祷拥有一颗透明的心灵
[00:57.85]和会流泪的眼睛
[01:03.39]给我再去相信的勇气
[01:06.49]oh越过谎言去拥抱你
[01:10.66]每当我找不到存在的意义
[01:15.36]每当我迷失在黑夜里
[01:19.72]oh...夜空中最亮的星
[01:24.49]请指引我靠近你
[01:29.50]
[01:38.47]夜空中最亮的星
[01:42.64]是否知道
[01:47.03]曾与我同行的身影 如今在哪里
[01:56.00]oh夜空中最亮的星
[02:00.41]是否在意
[02:04.52]是等太阳升起
[02:06.98]还是意外先来临
[02:12.59]我宁愿所有痛苦都留在心里
[02:17.68]也不愿忘记你的眼睛
[02:23.44]给我再去相信的勇气
[02:26.47]oh越过谎言去拥抱你
[02:30.80]每当我找不到存在的意义
[02:35.30]每当我迷失在黑夜里
[02:39.83]oh...夜空中最亮的星
[02:44.36]oh请照亮我前行
[02:49.62]
[03:05.93]我祈祷拥有一颗透明的心灵
[03:11.31]和会流泪的眼睛
[03:16.72]给我再去相信的勇气
[03:19.74]oh越过谎言去拥抱你
[03:24.10]每当我找不到存在的意义
[03:28.68]每当我迷失在黑夜里
[03:33.22]oh...夜空中最亮的星
[03:37.66]oh请照亮我前行
[04:12.46]
''';
  //音译/翻译歌词
  var remarkSongLyc = "";
  // "[00:00.680]照亮明天的阳光\n[00:03.570]从窗外洒进来…敞开门扉\n[00:20.920]停下!因为你让我感觉到\n[00:22.360]自己有点过快\n[00:23.520]走吧!也许脱离了节奏\n[00:25.100]但我绝不放开你\n[00:26.280]知道吗!我希望你能亲自看看\n[00:28.560]不是这样不是这样快停下听好!糟了!\n[00:30.930]我从来没想过我会接受这一切\n[00:33.420]现在我知道我没办法降低速度\n[00:35.970]你知道这是不断地和不时地\n[00:38.210]于是谁也无法逃脱\n[00:40.300]我的梦想究竟落在何方?\n[00:45.100]为何形影不见\n[00:50.200]奋力追赶着应当守护的事物\n[00:54.860]阳光至始至终都在我心底里\n[01:02.400]照亮明天的阳光无限延伸\n[01:07.340]向着展现眼前的光明前路\n[01:12.870]Sunshine未来的阳光\n[01:15.420]Sunshine耀眼的阳光\n[01:18.100]你知道难以达成只是想去尝试一番\n[01:19.670]相信吧\n[01:21.289]明天也会放晴吗?\n[01:32.960]常因些微不足道的事情踌躇不前\n[01:37.830]总是很在意某人说过的话\n[01:42.850]如此脆弱的我亦坚信「早日必定成功!」\n[01:47.800]这是逞强还是不服输?\n[01:51.940]我的梦想实为何物\n[01:56.720]竟忘了如此重要的事\n[02:01.680]应当守护的事物就在眼前\n[02:06.640]阳光至始至终都在我心底里\n[02:14.500]照亮明天的阳光无限延伸\n[02:19.000]向着展现眼前的光明前路\n[02:24.670]未来的阳光\n[02:27.200]耀眼的阳光\n[02:29.900]你知道难以达成只是想去尝试一番\n[02:31.420]相信吧\n[02:33.300]明天也会放晴吗?\n[02:47.200]此刻雨水纷飞\n[03:05.650]我推测我所等待的就是这缕阳光\n[03:09.200]为什么它只在我心中闪烁\n[03:15.960]我推测我所等待的就是这缕阳光\n[03:19.110]为什么它只在我心中闪烁\n[03:25.970]照亮明天的阳光无限延伸\n[03:30.690]向着展现眼前的光明前路\n[03:36.400]未来的阳光\n[03:38.840]耀眼的阳光\n[03:41.520]你知道难以达成只是想去尝试一番\n[03:43.200]相信吧\n[03:44.829]明天也会放晴吗?";
  //是否显示选择器
  bool showSelect = true;
  //歌词控制器
  LyricController controller;

  @override
  void initState() {
    controller = LyricController(vsync: this);

    //监听控制器
    controller.addListener(() {
      //如果拖动歌词则显示选择器
      if (showSelect != controller.isDragging) {
        setState(() {
          showSelect = controller.isDragging;
        });
      }
    });
    if (_countdownTimer != null) {
      return;
    }
    _countdownTimer = new Timer.periodic(new Duration(seconds: 1), (timer) {
      // setState(() {
      //   _countdownNum--;
      //   print(_countdownNum);
      //   start = start + new Duration(seconds: 10);
      //   if (_countdownNum == 0) {
      //     _countdownTimer.cancel();
      //   }
      // });
    });
    super.initState();
  }

  double slider = 0;
  bool isPlaying = false;

  Timer _countdownTimer;
  Duration start = new Duration(seconds: 0);

  @override
  Widget build(BuildContext context) {
    var lyrics = LyricUtil.formatLyric(songLyc);
    // var remarkLyrics = LyricUtil.formatLyric(remarkSongLyc);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 40.h,
        backgroundColor: ThemeColors.colorWhite,
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: Container(
          decoration: ThemeFonts.lineBoxDecoration,
          child: Column(
            children: <Widget>[
              Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Center(
                        child: LyricWidget(
                      lyricGap: 20.h,
                      lyricStyle: TextStyle(
                          color: Colors.black.withAlpha(150), fontSize: 16),
                      remarkStyle: TextStyle(color: Colors.black, fontSize: 16),
                      currLyricStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                      currRemarkLyricStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                      draggingLyricStyle: TextStyle(
                          color: ThemeColors.colorBlack,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                      draggingRemarkLyricStyle:
                          TextStyle(color: Colors.black, fontSize: 16),
                      size: Size(double.infinity, double.infinity),
                      lyrics: lyrics,
                      controller: controller,
                      // remarkLyrics: remarkLyrics,
                    )),
                    Offstage(
                      offstage: !showSelect,
                      child: GestureDetector(
                        onTap: () {
                          //点击选择器后移动歌词到滑动位置;
                          controller.draggingComplete();
                          //当前进度
                          print("进度:${controller.draggingProgress}");
                          setState(() {
                            slider = controller.draggingProgress.inSeconds
                                .toDouble();
                          });
                        },
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Ionicons.play,
                              color: ThemeColors.colorTheme,
                              size: 24.sp,
                            ),
                            Expanded(
                                child: Divider(
                              color: ThemeColors.colorBlack.withAlpha(0),
                              height: 2,
                              thickness: 2,
                            )),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Slider(
                activeColor: ThemeColors.colorBlack,
                inactiveColor: ThemeColors.colorBlack.withAlpha(100),
                onChanged: (d) {
                  setState(() {
                    slider = d;
                  });
                },
                onChangeEnd: (d) {
                  controller.progress = Duration(seconds: d.toInt());
                  print(d);
                },
                value: slider,
                max: 320,
                min: 0,
              ),
              // 控制区
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(Ionicons.heart),
                    onPressed: () => {},
                    iconSize: 24.sp,
                  ),
                  IconButton(
                    icon: Icon(Ionicons.play_skip_back),
                    onPressed: () => {},
                    iconSize: 24.sp,
                  ),
                  IconButton(
                    icon: Icon(Ionicons.play_circle_sharp),
                    iconSize: 44.sp,
                    onPressed: () => {},
                  ),
                  IconButton(
                    icon: Icon(Ionicons.play_skip_forward),
                    iconSize: 24.sp,
                    onPressed: () => {},
                  ),
                  IconButton(
                    icon: Icon(Ionicons.list),
                    onPressed: () => {},
                    iconSize: 24.sp,
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
