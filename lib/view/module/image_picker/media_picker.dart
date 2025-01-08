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

  XFile? _selectedMedia;
  VideoPlayerController? _videoPlayerController;

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    super.dispose();
  }

  Future<void> openGallery() async {
    var image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedMedia = image;
      });
    }
  }

  Future<void> openVideo() async {
    var video = await _imagePicker.pickVideo(source: ImageSource.gallery);
    if (video != null) {
      setState(() {
        _selectedMedia = video;
        _initializeVideoPlayer(video.path);
      });
    }
  }

  void _initializeVideoPlayer(String path) {
    _videoPlayerController = VideoPlayerController.file(File(path))
      ..initialize().then((_) {
        // Refresh UI once video is initialized
        setState(() {}); 
      });
  }

  void deleteMedia() {
    setState(() {
      _selectedMedia = null;
      _videoPlayerController?.dispose();
      _videoPlayerController = null;
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
                  if (_selectedMedia != null)
                    if (_selectedMedia!.path.endsWith(".mp4"))
                      _videoPlayerController != null &&
                              _videoPlayerController!.value.isInitialized
                          ? AspectRatio(
                              aspectRatio:
                                  _videoPlayerController!.value.aspectRatio,
                              child: VideoPlayer(_videoPlayerController!),
                            )
                          : const Center(child: CircularProgressIndicator())
                    else
                      Image.file(
                        File(_selectedMedia!.path),
                        fit: BoxFit.fitWidth,
                      )
                  else
                    const Center(child: Text("No media selected")),
                  if (_videoPlayerController != null &&
                      _videoPlayerController!.value.isInitialized)
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _videoPlayerController!.value.isPlaying
                              ? _videoPlayerController!.pause()
                              : _videoPlayerController!.play();
                        });
                      },
                      child: Text(
                        _videoPlayerController!.value.isPlaying
                            ? "Pause Video"
                            : "Play Video",
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openMediaAction(context);
        },
        tooltip: 'Media Actions',
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
                Navigator.pop(context);
                openGallery();
              },
              child: const Text("Gallery"),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                openVideo();
              },
              child: const Text("Video"),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                deleteMedia();
              },
              child: const Text("Delete"),
            ),
          ),
        ],
      ),
    );
  }
}
