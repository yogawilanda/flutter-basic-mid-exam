part of 'task_controller_libraries.dart';

extension TaskControllerUtilitiesController on TaskController {
  Future<void> requestStoragePermission() async {
    var status = await Permission.storage.request();
    if (!status.isGranted) {
      throw Exception('Storage permission is required.');
    }
  }

  Future<void> openConfigurationHandler() async {
    openAppSettings();
  }

  Future<void> requestManageStoragePermission() async {
    if (await Permission.manageExternalStorage.request().isGranted) {
      debugPrint('Permission granted');
    } else {
      debugPrint('Permission denied');
    }
  }

  Future<void> openDownloadFolder() async {
    final downloadsPath = '/storage/emulated/0/Download';
    final downloadsUri = Uri.parse('file://$downloadsPath');

    if (await canLaunchUrl(downloadsUri)) {
      await launchUrl(downloadsUri, mode: LaunchMode.externalApplication);
      debugPrint('Opened folder: $downloadsPath');
    } else {
      debugPrint('Could not open folder: $downloadsPath');
    }
  }

  Future<void> createFolderInExternalStorage() async {
    // Request storage permission and handle the response with a ternary operator
    final status = await Permission.storage.request();
    if (!status.isGranted) {
      debugPrint('Storage permission not granted.');
      return;
    }

    // Get the external storage directory or handle failure
    final externalDir = await getExternalStorageDirectory();
    if (externalDir == null) {
      debugPrint('Failed to get external storage directory.');
      return;
    }
    
    // Define the folder path in the external storage's "Download" directory
    final folderPath = '${externalDir.parent.path}/Downloads/MyFolder';


    // Create the folder if it doesn't exist, using ternary operator
    (await Directory(folderPath).exists())
        ? debugPrint('Folder already exists at: $folderPath')
        : await Directory(folderPath).create(recursive: true).then((_) {
            debugPrint('Folder created at: $folderPath');
          });
  }

  Future<bool> checkPermissionStatus() async {
    const permission = Permission.accessMediaLocation;
    return permission.isGranted;
  }
}
