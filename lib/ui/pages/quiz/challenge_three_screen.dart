import 'package:flutter/material.dart';
import 'package:suyu_simple/model/quiz/question.dart';
import 'package:suyu_simple/net/quiz.dart' as network;
import 'package:suyu_simple/ui/components/Quiz/bouncing_widget.dart';
import 'package:suyu_simple/ui/components/Quiz/number_timer.dart';
import 'package:suyu_simple/ui/pages/quiz/quiz_screen.dart';
import 'package:suyu_simple/constant/default_gradient.dart';

class ChallengeThreeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ChallengeThreeScreenState();
}

class _ChallengeThreeScreenState extends State<ChallengeThreeScreen> {
  bool loading = true;
  int current = 0;
  @override
  void initState() {
    super.initState();
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.center,
        decoration: BoxDecoration(gradient: DefaultGradient.defaultGradient),
        child: loading
            ? NumberTimer(onCompleted: () {
                setState(() {
                  this.loading = false;
                  current++;
                });
              })
            : current < questions.length
                ? QuizScreen(
                    question: questions[current],
                    onCompleted: () {
                      setState(() {
                        this.loading = true;
                      });
                    },
                  )
                : BouncingWidget(
                    duration: Duration(seconds: 2),
                    child: Text(
                      "结束",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.15,
                          color: Colors.white,
                          fontWeight: FontWeight.w900),
                    )),
      ),
    );
    // return Scaffold();
  }

  List<Question> questions = [];
  void refresh() {
    network.getQuestions().then((ques) {
      print(ques.length);
      if (mounted) {
        setState(() {
          questions.clear();
          questions.addAll(ques);
        });
      }
    });
  }
}
