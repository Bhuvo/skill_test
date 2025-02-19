import 'dart:async';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class WebVideoPlayer extends StatefulWidget {
  final String videoUrl;
  const WebVideoPlayer({super.key, required this.videoUrl});

  @override
  State<WebVideoPlayer> createState() => _WebVideoPlayerState();
}

class _WebVideoPlayerState extends State<WebVideoPlayer> {
  late VideoPlayerController _videoController;
  ChewieController? _chewieController;
  Timer? _timer;
  List<dynamic> questions = [];
  int currentQuestionIndex = 0;
  bool isQuestionPopupVisible = false;

  Future<void> _startTracking() async {
    _timer =Timer.periodic( Duration(seconds: 1), (timer) async {
      if (_videoController.value.isPlaying && !isQuestionPopupVisible) {
        int currentTime = _videoController.value.position.inSeconds;
        if (currentQuestionIndex < questions.length &&
            currentTime == questions[currentQuestionIndex]['timestamp']) {
          await  _showQuestionPopup();
        }else{
        }
      }else{
      }
    });
  }

  Future<void> _showQuestionPopup() async {
    _videoController.pause();
    print('the audio is paused');
    isQuestionPopupVisible = true;
    List<dynamic> options = questions[currentQuestionIndex]['options'];
    await  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text("Answer Dialog"),
        content: Row(
          // mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text(questionText),
            ...options.map((option) => Padding(
              padding: const EdgeInsets.all(5),
              child: ElevatedButton(
                onPressed: () {
                  _answerSelected();
                  _videoController.value = _videoController.value.copyWith(position: Duration(seconds: questions[currentQuestionIndex]['start']));
                },
                child: Text(option),
              ),
            )),
          ],
        ),
      ),
    );
  }

  void _answerSelected() {
    Navigator.pop(context);
    isQuestionPopupVisible = false;
    currentQuestionIndex++;
    _videoController.play(); // Resume video after answer
  }

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
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
    questions = jsonData['questions'];
    _videoController = VideoPlayerController.network(widget.videoUrl);
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
