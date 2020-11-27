import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:suyu_simple/net/chat_stream.dart';

void main() {
  testWidgets('ChatStream ...', (tester) async {
    ChatStream c = ChatStream.instance;

    StreamBuilder(
        stream: c.getStream(),
        initialData: "初始值",
        builder: (context, snapshot) {
          print(snapshot.data);
          return Text(snapshot.data);
        });
  });
}
