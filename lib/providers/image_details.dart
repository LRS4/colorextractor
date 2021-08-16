import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:palette_generator/palette_generator.dart';

class ImageDetailsProvider with ChangeNotifier {
  late FileImage _storedImage;
  late String _storedImagePath = "";
  bool _storedImageInitialised = false;
  PaletteGenerator? _paletteGenerator;

  Future<bool> getPictureFrom(source) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? _imageFile = await _picker.pickImage(
        source: source == "camera" ? ImageSource.camera : ImageSource.gallery,
        maxWidth: 600);

    if (_imageFile == null) {
      return false;
    }

    _storedImage = FileImage(File(_imageFile.path));
    _storedImagePath = _imageFile.path;
    _storedImageInitialised = true;

    Rect? region = Offset.zero & Size(200.0, 200.0);
    await updatePaletteGenerator(region);
    notifyListeners();

    return true;
  }

  Future<void> updatePaletteGenerator(Rect? newRegion) async {
    _paletteGenerator = await PaletteGenerator.fromImageProvider(
      _storedImage,
      size: Size(200.0, 200.0),
      region: newRegion,
      maximumColorCount: 16,
    );
    notifyListeners();
  }

  FileImage get storedImage {
    return _storedImage;
  }

  set storedImage(FileImage image) {
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

  PaletteGenerator? get paletteGenerator {
    return _paletteGenerator;
  }
}