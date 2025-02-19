import 'package:flutter/material.dart';
import 'package:skill_test/test_module/web_player.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Test Screen")),
      body: Center(
          child: Stack(
            children: [
              WebVideoPlayer(videoUrl: 'https://firebasestorage.googleapis.com/v0/b/app1-926c8.appspot.com/o/game.mp4?alt=media&token=78efcfe1-2766-42a5-b709-d426f5b5589b'),
              Positioned.fill(
                child: AbsorbPointer(
                  absorbing: true,
                  child: Container(color: Colors.transparent),
                ),
              ),
            ],
          )
      ),
    );
  }
}
