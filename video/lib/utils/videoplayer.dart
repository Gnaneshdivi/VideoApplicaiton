import 'dart:io';

import 'package:flutter/material.dart';

import 'package:video_player/video_player.dart';
import 'package:double_tap_player_view/double_tap_player_view.dart';

class Player extends StatefulWidget {
  const Player({
    Key? key,
    this.url,
    this.cover_url,
  }) : super(key: key);
  final url;
  final cover_url;

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  bool playing = false;

  late VideoPlayerController _controller;
  @override
  Future<void> abc() async {
    _controller = VideoPlayerController.file(File(widget.url))
      ..initialize().then((_) => setState(() {}));
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _controller.play();
      setState(() {
        playing = true;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: abc(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width * 0.7,
            child: playing
                ? Center(
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: DoubleTapPlayerView(
                        doubleTapConfig:
                            DoubleTapConfig.create(onDoubleTap: (lr) {
                          print('double tapped: $lr');
                        }),
                        swipeConfig:
                            SwipeConfig.create(overlayBuilder: _overlay),
                        child: VideoPlayer(_controller),
                      ),
                    ),
                  )
                : MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    removeBottom: true,
                    child: Image.asset(widget.cover_url,
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: MediaQuery.of(context).size.width * 0.5)),
          );
        });
  }
}

Widget _overlay(SwipeData data) {
  final dxDiff = (data.currentDx - data.startDx).toInt();
  final diffDuration = Duration(seconds: dxDiff);
  final prefix = diffDuration.isNegative ? '-' : '+';
  final positionText = '$prefix${diffDuration.printDuration()}';
  final aimedDuration = diffDuration + Duration(minutes: 5);
  final diffText = aimedDuration.printDuration();

  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          positionText,
          style: const TextStyle(
            fontSize: 30,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 4),
        Text(
          diffText,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ],
    ),
  );
}

extension on Duration {
  /// ref: https://stackoverflow.com/a/54775297/8183034
  String printDuration() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final twoDigitMinutes = twoDigits(inMinutes.abs().remainder(60));
    final twoDigitSeconds = twoDigits(inSeconds.abs().remainder(60));
    return '$twoDigitMinutes:$twoDigitSeconds';
  }
}
