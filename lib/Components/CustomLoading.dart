import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:suyu_simple/common/ThemeColor.dart';

class CustomLoadWidget extends StatefulWidget {
  final CancelFunc cancelFunc;

  const CustomLoadWidget({Key key, this.cancelFunc}) : super(key: key);

  @override
  _CustomLoadWidgetState createState() => _CustomLoadWidgetState();
}

class _CustomLoadWidgetState extends State<CustomLoadWidget>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));

    animationController.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        animationController.forward();
      }
    });
    animationController.forward();

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void handleTap() {
    BotToast.showCustomText(
        onlyOne: true,
        clickClose: true,
        duration: Duration(seconds: 1),
        toastBuilder: (textCancel) => Align(
              alignment: Alignment(0, 0.8),
              child: Card(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                        icon: Icon(
                          Icons.favorite,
                          color: Colors.redAccent,
                        ),
                        onPressed: () => {}),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text("已保存"),
                    )
                  ],
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => handleTap(),
        child: Container(
          child: FadeTransition(
            opacity: animationController,
            child:
                Icon(Icons.swap_vertical_circle, color: ThemeColors.colorBlack),
          ),
        ));
  }
}
