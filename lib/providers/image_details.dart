import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageDetailsProvider with ChangeNotifier {
  late File _storedImage;
  late String _storedImagePath = "";
  bool _storedImageInitialised = false;

  Future<bool> getPictureFrom(source) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? _imageFile = await _picker.pickImage(
        source: source == "camera" ? ImageSource.camera : ImageSource.gallery,
        maxWidth: 600);

    if (_imageFile != null) {
      _storedImage = File(_imageFile.path);
      _storedImagePath = _imageFile.path;
      _storedImageInitialised = true;
    }

    notifyListeners();
    return true;
  }

  File get storedImage {
    return _storedImage;
  }

  set storedImage(File image) {
    _storedImage = image;
    notifyListeners();
  }
  
  String get storedImagePath {
    return _storedImagePath;
  }

  set storedImagePath(String val) {
    _storedImagePath = val;
    notifyListeners();
  }

  bool get storedImageInitialised {
    return _storedImageInitialised;
  }

  set storedImageInitialised(bool val) {
    _storedImageInitialised = val;
    notifyListeners();
  }
}