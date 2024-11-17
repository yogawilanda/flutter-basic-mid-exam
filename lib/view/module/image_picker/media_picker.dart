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
  ImagePicker _imagePicker = ImagePicker();

  List<XFile> _image = [];

  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.asset(
      // use this for video from gallery
      // File(_image.isEmpty ? "" : _image.last.path.toString(), 
      _imageFile == null ? "" : _imageFile!.toString(),
    );
    
    // VideoPlayerController.networkUrl(Uri.parse(
    //     'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'))
    //   ..initialize().then((_) {
    //     // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
    //     setState(() {});
    //   });
  }

  Future<void> openCamera() async {
    var image = await _imagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        // get current image from camera
        debugPrint("Image Path: ${image.path}");
        _image.add(image);
      });
    }
  }

  //------------------cara mas rifqy------------------
  File? _imageFile;
  Future<void> pickImageAlaMasRifqy() async {
    final _imageFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (_imageFile == null) return;

    final imageTemporary = File(_imageFile.path);

    setState(() {
      this._imageFile = imageTemporary;
    });
  }

  Future<void> openGallery() async {
    var image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        // get current image from gallery
        _image.add(image);
      });
    }
  }

  Future<void> openVideo() async {
    var video = await _imagePicker.pickVideo(source: ImageSource.gallery);
    if (video != null) {
      setState(() {
        // get current video from gallery
        debugPrint("Video Path: ${video.path}");
      });
    }
  }

  void deleteImage() {
    setState(() {
      _image.clear();
    });
  }

  void openMediaAction(BuildContext context) {
    return setState(() {
      showModalBottomSheet(
          context: context, builder: (context) => buttonControl());
    });
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
                        : Image(
                            image: FileImage(
                              File(_image.isEmpty
                                  ? ""
                                  : _image.last.path.toString()),
                            ),
                          ),
                    // video player
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: VideoPlayer(_videoPlayerController),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      child: Text(_image.isEmpty
                          ? "No Image"
                          : _image.isEmpty
                              ? _image[0].path.toString().substring(45)
                              : _image.last.path.toString()),
                    ),
                  ],
                )),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _videoPlayerController.value.isPlaying
                      ? _videoPlayerController.pause()
                      : _videoPlayerController.play();
                });
              },
              child: Text(_videoPlayerController.value.isPlaying
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
        tooltip: 'Increment',
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
                debugPrint("open gallery");
                openGallery();
              },
              child: const Text("Gallery"),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                debugPrint("open camera");
                openCamera();
              },
              child: const Text("Camera"),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                // deleteImage();
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
