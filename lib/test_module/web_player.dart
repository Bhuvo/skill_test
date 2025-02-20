import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skill_test/model/test_model.dart';
import 'package:skill_test/service/local_storge.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class WebVideoPlayer extends StatefulWidget {
  const WebVideoPlayer({super.key});

  @override
  State<WebVideoPlayer> createState() => _WebVideoPlayerState();
}

class _WebVideoPlayerState extends State<WebVideoPlayer> {


  late VideoPlayerController _videoController;
  ChewieController? _chewieController;
  Timer? _timer;
  List<QuestionModel>?  questions = [];
  int currentQuestionIndex = 0;
  bool isQuestionPopupVisible = false;

  TestModel testData = TestModel();

  Future<void> getTestData()async {
    testData = TestModel.fromJson(jsonDecode(LocalStorage.getString(LocalStorage.testData)));
  }


  Future<void> _startTracking() async {
    _timer =Timer.periodic( Duration(seconds: 1), (timer) async {
      if (_videoController.value.isPlaying && !isQuestionPopupVisible) {
        int currentTime = _videoController.value.position.inSeconds;
        if (currentQuestionIndex < (questions?.length ?? 0) &&
            currentTime == questions?[currentQuestionIndex].timePause) {
          await  _showQuestionPopup();
        }else{
        }
      }else{
      }
    });
  }

  Future<void> _showQuestionPopup() async {
    _videoController.pause();
    print('The video is paused');
    isQuestionPopupVisible = true;

    int? selectedOptionIndex;

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder( // <--- Add StatefulBuilder
          builder: (context, setState) {
            return AlertDialog(
              title: Text("Answer Dialog"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ...List.generate(questions?[currentQuestionIndex].options.length ?? 0, (index) {
                    return RadioListTile<int>(
                      title: Text(questions?[currentQuestionIndex].options[index].answer ?? ''),
                      value: index,
                      groupValue: selectedOptionIndex,
                      onChanged: (value) {
                        setState(() { // <--- Use setState inside StatefulBuilder
                          selectedOptionIndex = value;
                        });
                      },
                    );
                  }),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      if (selectedOptionIndex != null) {
                        totalScore += questions?[currentQuestionIndex].options[selectedOptionIndex!].score ?? 0;
                        LocalStorage.setInt('total', totalScore);
                        // print('The score is $totalScore');
                        // print('the time is ${questions?[currentQuestionIndex].start ?? 0}');
                        // _videoController.value = _videoController.value.copyWith(
                        //   position: Duration(seconds: questions![currentQuestionIndex].start),
                        // );
                        _videoController.seekTo(Duration(seconds: questions![currentQuestionIndex].start));
                        setState(() {});
                        _answerSelected();
                      } else {
                        Get.snackbar("Selection Required", "Please select an option before confirming.");
                      }
                    },
                    child: Text("Confirm"),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _answerSelected() {
    Navigator.pop(context);
    isQuestionPopupVisible = false;
    currentQuestionIndex++;
    _videoController.play(); // Resume video after answer
  }
  int totalScore = 0;
  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    await getTestData();
    print(testData.videoUrl);
    final Map<String, dynamic> jsonData ={
      "questions": [
        {
          "text": "Question 1",
          "options": ['Yes' ,' No'],
          "timestamp": 11,
          'start' :17
        },
        {
          "text": "Question 2",
          "options": ['Yes' ,'No'],
          "timestamp": 27,
          'start' : 31
        },
        {
          "text": "Question 3",
          "options": ['Yes' ,'No'],
          "timestamp": 46,
          'start' : 51
        }
      ]
    };
    // questions = jsonData['questions'];
    questions = testData.questions ?? [];
    _videoController = VideoPlayerController.network(testData.videoUrl ?? '');
    await _videoController.initialize();
    _startTracking();
    _chewieController = ChewieController(
      videoPlayerController: _videoController,
      autoPlay: false,
      looping: false,
      allowFullScreen: false,
      aspectRatio: _videoController.value.aspectRatio,
      errorBuilder: (context, errorMessage) {
        print('Error: $errorMessage');
        return Center(child: Text(errorMessage, style: TextStyle(color: Colors.red)));
      },
    );

    setState(() {});
  }

  @override
  void dispose() {
    _videoController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _chewieController != null
        ? Chewie(controller: _chewieController!)
        : const Center(child: CircularProgressIndicator());
  }
}
