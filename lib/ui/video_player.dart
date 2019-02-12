import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';


class VideoPlayerContainer extends StatefulWidget {

  String videoPath;

  VideoPlayerContainer({Key key, this.videoPath}) : super(key: key);

  @override
  _VideoPlayerContainerState createState() => _VideoPlayerContainerState();
}

class _VideoPlayerContainerState extends State<VideoPlayerContainer> {

  VideoPlayerController playerController;
  VoidCallback listener;



  @override
  void initState() {
    super.initState();
    createVideo();
//    listener = () {
//      setState(() {print('VIDEOPATH: '+widget.videoPath);});
//    };
  }

  void createVideo() {
    if (playerController == null) {
      playerController = VideoPlayerController.file(File(widget.videoPath))
        ..addListener(listener)
        ..setVolume(1.0)
        ..initialize()
        ..play();
    } else {
      if (playerController.value.isPlaying) {
        playerController.pause();
      } else {
        playerController.initialize();
        playerController?.dispose();
        playerController.play();
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    playerController?.dispose();
  }

  @override
  void deactivate() {
    playerController.setVolume(0.0);
    playerController.removeListener(listener);
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Player'),
      ),
      body: Center(
          child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                child: (playerController != null
                    ? VideoPlayer(
                  playerController,
                )
                    : Container()),
              ))),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          createVideo();
          playerController.play();
        },
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}

