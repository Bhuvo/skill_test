import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skill_test/main.dart';
import 'package:skill_test/route/routes.dart';
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
      appBar: AppBar(title: Text("Test Screen"),

      actions: [
        OutlinedButton(onPressed: (){
          Get.offNamedUntil( Routes.splash, (route) => false);
        }, child: Text('Complete Test'))
      ],),
      body: Center(
          child: Stack(
            children: [
              WebVideoPlayer(),
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
