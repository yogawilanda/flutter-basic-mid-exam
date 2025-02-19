import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class MediaPicker extends StatefulWidget {
  const MediaPicker({super.key});

  @override
  State<MediaPicker> createState() => MediaPickerState();
}

class MediaPickerState extends State<MediaPicker> {
  final ImagePicker _imagePicker = ImagePicker();
  List<XFile> _image = [];
  XFile? _videoFile;
  VideoPlayerController? _videoPlayerController;

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    super.dispose();
  }

  Future<void> openCamera() async {
    var image = await _imagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _image.add(image);
      });
    }
  }

  Future<void> openGallery() async {
    var image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image.add(image);
      });
    }
  }

  Future<void> openVideo() async {
    var video = await _imagePicker.pickVideo(source: ImageSource.gallery);
    if (video != null) {
      setState(() {
        _videoFile = video;

        // Dispose the previous controller if it exists
        _videoPlayerController?.dispose();

        // Initialize the new VideoPlayerController
        _videoPlayerController = VideoPlayerController.file(File(video.path))
          ..initialize().then((_) {
            // Refresh the widget to reflect the changes
            setState(() {});
          });
      });
    }
  }

  void deleteImage() {
    setState(() {
      _image.clear();
    });
  }

  void openMediaAction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) => buttonControl(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Media Picker"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  _image.isEmpty
                      ? Container()
                      : Image.file(File(_image.last.path)),
                  // Video player
                  if (_videoPlayerController != null &&
                      _videoPlayerController!.value.isInitialized)
                    AspectRatio(
                      aspectRatio: _videoPlayerController!.value.aspectRatio,
                      child: VideoPlayer(_videoPlayerController!),
                    )
                  else
                    const Text("No video selected"),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: _videoPlayerController != null &&
                      _videoPlayerController!.value.isInitialized
                  ? () {
                      setState(() {
                        _videoPlayerController!.value.isPlaying
                            ? _videoPlayerController!.pause()
                            : _videoPlayerController!.play();
                      });
                    }
                  : null,
              child: Text(_videoPlayerController != null &&
                      _videoPlayerController!.value.isPlaying
                  ? "Pause Video"
                  : "Play Video"),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openMediaAction(context);
        },
        tooltip: 'Open Media',
        child: const Icon(Icons.add),
      ),
    );
  }

  Container buttonControl() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                openGallery();
              },
              child: const Text("Gallery"),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                openCamera();
              },
              child: const Text("Camera"),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                openVideo();
              },
              child: const Text("Video"),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                deleteImage();
              },
              child: const Text("Delete"),
            ),
          ),
        ],
      ),
    );
  }
}
