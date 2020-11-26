import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hand_signature/signature.dart';
import 'package:provider/provider.dart';
import 'package:suyu_simple/common/ThemeColor.dart';
import 'package:suyu_simple/provider/UserPictureProvider.dart';
import 'package:suyu_simple/route/RouterHelper.dart';

HandSignatureControl control = new HandSignatureControl(
  threshold: 5.0,
  smoothRatio: 0.65,
  velocityRange: 2.0,
);

ValueNotifier<String> svg = ValueNotifier<String>(null);

ValueNotifier<ByteData> rawImage = ValueNotifier<ByteData>(null);

class Paint extends StatefulWidget {
  Paint({Key key}) : super(key: key);

  @override
  _PaintState createState() => _PaintState();
}

class _PaintState extends State<Paint> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
  }

  @override
  void dispose() {
    super.dispose();

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300],
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // 预览区
              Container(
                height: 100.w,
                width: 300.h,
                decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                    color: Colors.black,
                    width: 3.0,
                  )),
                  color: ThemeColors.colorTheme,
                ),
                child: ValueListenableBuilder<String>(
                  valueListenable: svg,
                  builder: (context, data, child) {
                    return Container(
                      child: HandSignatureView.svg(
                        data: data,
                        placeholder: Container(
                          color: ThemeColors.colorTheme,
                          child: Center(
                            child: Text(
                              '还没有写东西',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16.sp),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // 右下角的操作区
              Container(
                height: 100.w,
                width: 367.h,
                decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                        color: Colors.black,
                        width: 3.0,
                      ),
                      left: BorderSide(
                        color: Colors.black,
                        width: 3.0,
                      )),
                  color: ThemeColors.colorWhite,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FlatButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      color: Colors.transparent,
                      child: Container(
                        padding: EdgeInsets.only(
                          left: 15.h,
                          right: 15.h,
                          top: 10.h,
                          bottom: 10.h,
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(width: 3),
                            borderRadius: BorderRadius.circular(10)),
                        child: Text('清空'),
                      ),
                      onPressed: control.clear,
                    ),
                    FlatButton(
                      child: Container(
                        padding: EdgeInsets.only(
                          left: 15.h,
                          right: 15.h,
                          top: 10.h,
                          bottom: 10.h,
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(width: 3),
                            borderRadius: BorderRadius.circular(10)),
                        child: Text('预览'),
                      ),
                      onPressed: () async {
                        svg.value = control.toSvg(
                          color: Colors.black,
                          size: 2.0,
                          maxSize: 10.0,
                          type: SignatureDrawType.shape,
                        );
                        if (control.lines.isEmpty) {
                          EasyLoading.showError("还没开始创作?");
                        } else {
                          rawImage.value = await control.toImage(
                            color: Colors.black,
                          );
                        }
                      },
                    ),
                    FlatButton(
                      child: Container(
                        padding: EdgeInsets.only(
                          left: 15.h,
                          right: 15.h,
                          top: 10.h,
                          bottom: 10.h,
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(width: 3),
                            borderRadius: BorderRadius.circular(10)),
                        child: Text('保存'),
                      ),
                      onPressed: () async {
                        String tmp = control.toSvg(
                          color: Colors.black,
                          size: 2.0,
                          maxSize: 10.0,
                          type: SignatureDrawType.shape,
                        );

                        if (control.lines.isEmpty) {
                          EasyLoading.showError("还没开始创作?");
                        } else {
                          Provider.of<UserPictureProvider>(context,
                                  listen: false)
                              .saveSvg(tmp);
                          EasyLoading.showSuccess("保存成功");
                        }
                      },
                    ),
                    FlatButton(
                      child: Container(
                        padding: EdgeInsets.only(
                          left: 15.h,
                          right: 15.h,
                          top: 10.h,
                          bottom: 10.h,
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(width: 3),
                            borderRadius: BorderRadius.circular(10)),
                        child: Text('退出'),
                      ),
                      onPressed: () => RouterHelper.router.pop(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                height: (375 - 100).w,
                width: 675.h,
                child: HandSignaturePainterView(
                  control: control,
                  type: SignatureDrawType.shape,
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "创作区",
                    style: TextStyle(
                        color: Colors.black.withAlpha(60),
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Widget _buildImageView() => Container(
//       height: 505.h,
//       width: 150.w,
//       decoration: BoxDecoration(
//         border: Border.all(),
//         color: Colors.white30,
//       ),
//       child: ValueListenableBuilder<ByteData>(
//         valueListenable: rawImage,
//         builder: (context, data, child) {
//           if (data == null) {
//             return Container(
//               color: Colors.red,
//               child: Center(
//                 child: Text('not signed yet (png)'),
//               ),
//             );
//           } else {
//             return Padding(
//               padding: EdgeInsets.all(8.0),
//               child: Image.memory(data.buffer.asUint8List()),
//             );
//           }
//         },
//       ),
//     );

// Widget _buildSvgView() => Container(
//       height: 150.w,
//       width: 675.h,
//       decoration: BoxDecoration(
//         border: Border.all(),
//         color: ThemeColors.colorTheme,
//       ),
//       child: ValueListenableBuilder<String>(
//         valueListenable: svg,
//         builder: (context, data, child) {
//           return Expanded(
//             child: Container(
//               constraints: BoxConstraints.expand(),
//               child: HandSignatureView.svg(
//                 data: data,
//                 placeholder: Container(
//                   color: Colors.red,
//                   child: Center(
//                     child: Text('not signed yet (svg)'),
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
